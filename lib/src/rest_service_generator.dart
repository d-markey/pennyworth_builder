import 'package:pennyworth/annotations.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'extensions.dart';
import 'annotations/rest_service_annotation.dart';
import 'descriptors/operation_loader.dart';
import 'descriptors/middleware_loader.dart';
import 'helpers.dart';

class RestServiceGenerator extends GeneratorForAnnotation<RestService> {
  RestServiceGenerator(this._loader);

  final OperationLoader _loader;

  @override
  Iterable<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classElt = element;
    if (classElt is! ClassElement) return const [];
    // implementation moved to a specific method to facilitate unit tests
    return generateServiceSpec(classElt);
  }

  Iterable<String> generateServiceSpec(ClassElement classElt) sync* {
    final restService = RestServiceAnnotation.load(classElt);
    if (restService == null) return;

    final operations = classElt.methods
        .where((method) => !method.name.startsWith('_'))
        .expand((method) => _loader.load(classElt, method, restService))
        .toList();

    final operationEntities = operations
        .expand((o) => [o.input, o.output])
        .whereNotNull()
        .where((t) => !t.isDynamic && !t.isScalar)
        .toSet();

    if (operations.isNotEmpty) {
      yield '// REST Service ${classElt.name}';

      yield '''

// ignore: camel_case_extensions
extension ${classElt.name.upperCamelCase()}_MounterExt on NestedRoute {

  static Future _process(HttpRequest req, HttpResponse res, FutureOr Function(HttpRequest req, HttpResponse res) body) async {
    try {
      var ret = body(req, res);
      if (ret is Future) {
        ret = await ret;
      }
      return ret;
    } on AlfredException {
      rethrow;
    } catch (ex) {
      throw AlfredException(
          HttpStatus.internalServerError, 'Internal Server Error');
    }
  }

  // ignore: non_constant_identifier_names
  List<OpenApiRoute> mount_${classElt.name.upperCamelCase()}(${classElt.name} api, OpenApiService openApiService) {
    // ensure types used by these operations are registered
    ${operationEntities.map((t) => 'openApiService.register${t.name.upperCamelCase()}();').toSet().join('\n')}

    // mount operations on the service's base URI
    final mountPoint = route(${restService.uri.stringLiteral()}, middleware: ${MiddlewareLoader.load(restService.middleware)});
    final tags = [${restService.tags?.map((t) => t.stringLiteral()).join(', ') ?? ''}];
    return <OpenApiRoute>[
      ${operations.map((o) => o.code).join(',\n')}
    ];
  }
}
      ''';
    }
  }
}
