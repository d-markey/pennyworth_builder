import 'package:analyzer/dart/element/type.dart';
import 'package:pennyworth/annotations.dart';
import 'package:analyzer/dart/element/element.dart';

import '../extensions.dart';
import 'annotation_reader.dart';

class RestFieldAnnotation {
  RestFieldAnnotation._(this.ignored, this.title, this.type, this.format,
      this.mimeType, this.nullable, this.required, this.tags);

  final bool ignored;

  final String? title;
  final List<String>? tags;

  final DartType? type;
  final String? format;
  final String? mimeType;
  final bool? nullable;
  final bool? required;

  static RestFieldAnnotation? load(Element element) {
    final reader = AnnotationReader<RestField>(element);
    if (reader.isEmpty) return null;
    return RestFieldAnnotation._(
        reader.isSet('ignored'),
        reader.getString('title'),
        reader.getType('type'),
        reader.getString('format'),
        reader.getString('mimeType'),
        reader.getBoolean('nullable'),
        reader.getBoolean('required'),
        reader
            .getList('tags')
            ?.map((t) => t.toStringValue()?.trim())
            .whereNotEmpty()
            .toList());
  }
}
