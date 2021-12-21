import 'package:pennyworth/annotations.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';

import '../extensions.dart';
import 'annotation_reader.dart';

class RestServiceAnnotation {
  RestServiceAnnotation._(this.uri, this.title, this.tags, this.middleware);

  final String? uri;
  final String? title;
  final List<String>? tags;

  final List<List<DartObject>>? middleware;
  bool get hasMiddleware => middleware != null && middleware!.isNotEmpty;

  static RestServiceAnnotation? load(Element element) {
    final reader = AnnotationReader<RestService>(element);
    if (reader.isEmpty) return null;
    return RestServiceAnnotation._(
        reader.getString('uri'),
        reader.getString('title'),
        reader
            .getList('tags')
            ?.map((t) => t.toStringValue()?.trim())
            .whereNotEmpty()
            .toList(),
        reader
            .getList('middleware')
            ?.map((o) => o.toListValue())
            .whereNotEmpty()
            .toList());
  }
}
