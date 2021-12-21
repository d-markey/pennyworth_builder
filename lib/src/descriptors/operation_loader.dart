import 'package:alfred/alfred.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

import '../extensions.dart';
import '../annotations/rest_operation_annotation.dart';
import '../annotations/rest_service_annotation.dart';
import '../helpers.dart';
import 'middleware_loader.dart';
import 'operation_descriptor.dart';
import 'type_descriptor.dart';
import 'type_loader.dart';

class OperationLoader {
  OperationLoader(this._typeLoader);

  final TypeLoader _typeLoader;

  Iterable<OperationDescriptor> load(Element parent, MethodElement method,
      RestServiceAnnotation restService) sync* {
    // load annotations
    final restOperation = RestOperationAnnotation.load(method);
    if (restOperation == null) return;

    var httpMethods = restOperation.httpMethods;
    if (httpMethods == null || httpMethods.isEmpty) {
      httpMethods = ['get'];
    }

    var uri = restOperation.uri;
    if (uri == null || uri.isEmpty) {
      uri = method.name;
    }

    var path = restService.uri ?? '';
    while (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    var idx = 0;
    while (idx < uri.length && uri[idx] == '/') {
      idx++;
    }

    if (idx < uri.length) {
      path += '/${uri.substring(idx)}';
    }

    final routeParams = path
        .split('/')
        .map((s) => HttpRouteParam.tryParse(s))
        .whereNotEmpty()
        .toList();

    TypeDescriptor? inputTypeDescr;
    final input = restOperation.input;
    if (input != null) {
      inputTypeDescr = _typeLoader.load(input);
    }

    TypeDescriptor? outputTypeDescr;
    final output = restOperation.output;
    if (output != null) {
      outputTypeDescr = _typeLoader.load(output);
    }

    final returnTypeDescr = _typeLoader.load(method.returnType);

    if (outputTypeDescr != null &&
        returnTypeDescr != null &&
        (outputTypeDescr.name != returnTypeDescr.name ||
            outputTypeDescr.isArray != returnTypeDescr.isArray)) {
      log.warning(
          'Inconsistent return type between method implementation ${returnTypeDescr.name} and output annotation ${outputTypeDescr.name}');
    }

    if (outputTypeDescr == null &&
        returnTypeDescr != null &&
        !returnTypeDescr.isScalar &&
        !returnTypeDescr.isDynamic) {
      outputTypeDescr = returnTypeDescr;
    }

    var isAsync = false;

    final bodyLines = <String>[];
    final methodArgs = <String>[];

    for (var methodParam in method.parameters) {
      final paramType = _typeLoader.load(methodParam.type);
      if (paramType == null || paramType.isFuture) {
        final errMsg =
            'Unsupported parameter type for $methodParam in ${method.name}';
        bodyLines.add(
            'throw AlfredException(HttpStatus.internalServerError, ${errMsg.stringLiteral()});');
        log.warning(errMsg);
        continue;
      }
      if (paramType.name == 'HttpRequest') {
        methodArgs.addArgument(methodParam, 'req');
        continue;
      }
      if (paramType.name == 'HttpResponse') {
        methodArgs.addArgument(methodParam, 'res');
        continue;
      }
      if (inputTypeDescr != null && paramType.name == inputTypeDescr.name) {
        isAsync = true;
        bodyLines.add(
            'final input = await ${inputTypeDescr.getRequestReaderCode('req')};');
        methodArgs.addArgument(methodParam, 'input');
        continue;
      }
      final paramName = methodParam.name.toLowerCase();
      final routeParam = routeParams.where((p) => p.name == paramName).toList();
      if (routeParam.length == 1) {
        bodyLines.add(
            'final $paramName = req.params[${routeParam[0].name.stringLiteral()}];');
        methodArgs.addArgument(methodParam, paramName);
        continue;
      }
      if (inputTypeDescr == null) {
        inputTypeDescr = paramType;
        isAsync = true;
        bodyLines.add(
            'final input = await ${inputTypeDescr.getRequestReaderCode('req')};');
        methodArgs.addArgument(methodParam, 'input');
        continue;
      }
      final errMsg = 'Unsupported parameter $methodParam in ${method.name}';
      bodyLines.add(
          'throw AlfredException(HttpStatus.internalServerError, ${errMsg.stringLiteral()});');
      log.warning(errMsg);
    }

    if (method.returnType.isVoid) {
      bodyLines.add('api.${method.name}(${methodArgs.join(', ')});');
    } else if (method.returnType.isDartAsyncFuture ||
        method.returnType.isDartAsyncFutureOr) {
      isAsync = true;
      bodyLines
          .add('return await api.${method.name}(${methodArgs.join(', ')});');
    } else {
      bodyLines.add('return api.${method.name}(${methodArgs.join(', ')});');
    }

    final body = bodyLines.join('\n');

    String middleware = '';
    if (restOperation.middleware != null &&
        restOperation.middleware!.isNotEmpty) {
      middleware =
          'middleware: ${MiddlewareLoader.load(restOperation.middleware)}';
    }

    var operationId = restOperation.operationId;
    if (operationId == null || operationId.isEmpty) {
      operationId = '${parent.name}.${method.name}';
    }

    final summary = restOperation.summary;

    List<String>? tags = restOperation.tags;

    final args = {
      if (summary != null && summary.isNotEmpty)
        'summary': summary.stringLiteral(),
      'operationId': operationId.stringLiteral(),
      if (inputTypeDescr != null)
        'input': inputTypeDescr.isArray
            ? 'List<${inputTypeDescr.name}>'
            : inputTypeDescr.name,
      if (outputTypeDescr != null)
        'output': outputTypeDescr.isArray
            ? 'List<${outputTypeDescr.name}>'
            : outputTypeDescr.name,
      'tags': (tags == null || tags.isEmpty)
          ? 'tags'
          : 'tags.followedBy([${tags.map((t) => t.stringLiteral()).join(', ')}])',
    };

    for (var httpMethod in httpMethods) {
      var routeCode =
          '''mountPoint.$httpMethod(${uri.stringLiteral()}, (req, res) => _process(req, res, (req, res) ${isAsync ? 'async ' : ''}{
            $body
          }), $middleware)''';

      if (httpMethods.length > 1) {
        args['operationId'] = '$operationId.$httpMethod'.stringLiteral();
      }

      yield OperationDescriptor(inputTypeDescr, outputTypeDescr,
          'OpenApiRoute($routeCode, ${args.entries.map((e) => '${e.key}: ${e.value}').join(', ')})');
    }
  }

  String buildPath(String baseUri, String uri) {
    while (baseUri.endsWith('/')) {
      baseUri = baseUri.substring(0, baseUri.length - 1);
    }
    while (uri.startsWith('/')) {
      uri = uri.substring(1);
    }
    return '$baseUri/$uri';
  }
}
