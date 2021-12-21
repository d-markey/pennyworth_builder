import 'package:pennyworth/annotations.dart';
import 'package:analyzer/dart/element/element.dart';

import '../extensions.dart';
import 'annotation_reader.dart';

class RestFieldAnnotation {
  RestFieldAnnotation._(this.ignored, this.title, this.format, this.mimeType,
      this.required, this.tags);

  final bool ignored;

  final String? title;
  final List<String>? tags;

  final String? format;
  final String? mimeType;
  final bool required;

  static RestFieldAnnotation? load(Element element) {
    final reader = AnnotationReader<RestField>(element);
    if (reader.isEmpty) return null;
    return RestFieldAnnotation._(
        reader.isSet('ignored'),
        reader.getString('title'),
        reader.getString('format'),
        reader.getString('mimeType'),
        reader.getBoolean('required') ?? false,
        reader
            .getList('tags')
            ?.map((t) => t.toStringValue()?.trim())
            .whereNotEmpty()
            .toList());
  }
}
