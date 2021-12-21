import 'package:pennyworth/annotations.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import '../extensions.dart';
import 'annotation_reader.dart';

class RestOperationAnnotation {
  RestOperationAnnotation._(this.httpMethods, this.uri, this.operationId,
      this.summary, this.tags, this.input, this.output, this.middleware);

  final List<String>? httpMethods;
  final String? uri;
  final String? operationId;
  final String? summary;
  final List<String>? tags;

  final DartType? input;
  final DartType? output;

  final List<List<DartObject>>? middleware;
  bool get hasMiddleware => middleware != null && middleware!.isNotEmpty;

  static RestOperationAnnotation? load(Element element) {
    final reader = AnnotationReader<RestOperation>(element);
    if (reader.isEmpty) return null;
    return RestOperationAnnotation._(
        reader
            .getList('httpMethod')
            ?.map((o) => o.toStringValue()?.trim().toLowerCase() ?? '')
            .whereNotEmpty()
            .toList(),
        reader.getString('uri'),
        reader.getString('operationId'),
        reader.getString('summary'),
        reader
            .getList('tags')
            ?.map((t) => t.toStringValue()?.trim())
            .whereNotEmpty()
            .toList(),
        reader.getType('input'),
        reader.getType('output'),
        reader
            .getList('middleware')
            ?.map((o) => o.toListValue())
            .whereNotEmpty()
            .toList());
  }
}
