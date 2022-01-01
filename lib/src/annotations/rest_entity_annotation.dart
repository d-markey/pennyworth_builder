import 'package:pennyworth/annotations.dart';
import 'package:analyzer/dart/element/element.dart';

import '../extensions.dart';
import 'annotation_reader.dart';

class RestEntityAnnotation {
  RestEntityAnnotation._(this.title, this.tags, this.autoSerialize);

  final String? title;
  final List<String>? tags;
  final bool? autoSerialize;

  static RestEntityAnnotation? load(Element element) {
    final reader = AnnotationReader<RestEntity>(element);
    if (reader.isEmpty) return null;
    return RestEntityAnnotation._(
        reader.getString('title'),
        reader
            .getList('tags')
            ?.map((t) => t.toStringValue()?.trim())
            .whereNotEmpty()
            .toList(),
        reader.getBoolean('autoSerialize'));
  }
}
