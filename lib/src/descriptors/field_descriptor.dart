import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';

import '../annotations/rest_field_annotation.dart';
import '../helpers.dart';
import 'type_descriptor.dart';

class FieldDescriptor {
  FieldDescriptor(FieldElement element, this.type, this.annotation)
      : name = element.name,
        nullable = element.type.isDynamic ||
            (element.type.nullabilitySuffix == NullabilitySuffix.question);

  final RestFieldAnnotation? annotation;
  final String name;
  final TypeDescriptor type;
  final bool nullable;

  @override
  String toString() => '$type${nullable ? '?' : ''} $name';

  String getSerializerCode() {
    if (type.isArray) {
      if (type.isScalar) {
        return name;
      } else {
        final accessor = nullable ? '?' : '';
        return '$name$accessor.map((item) => item.${type.getSerializer()}).toList()';
      }
    } else {
      if (type.isScalar) {
        return name;
      } else {
        final accessor = nullable ? '?' : '';
        return '$name$accessor.${type.getSerializer()}';
      }
    }
  }

  String getDeserializerCode(String json) {
    if (type.isArray) {
      if (type.isScalar) {
        return '$json[${name.stringLiteral()}]';
      } else {
        final accessor = nullable ? '?' : '';
        return '$json[${name.stringLiteral()}]$accessor.map((item) => ${type.getDeserializer('(item as Map<String, dynamic>)')}).toList()';
      }
    } else {
      if (type.isScalar) {
        return '$json[${name.stringLiteral()}]';
      } else if (nullable) {
        return '($json[${name.stringLiteral()}] == null) ? null : ${type.getDeserializer('($json[${name.stringLiteral()}] as Map<String, dynamic>)')}';
      } else {
        return type.getDeserializer('($json[${name.stringLiteral()}] as Map<String, dynamic>)');
      }
    }
  }

  static String? _getSpecTypeName(String name) {
    if (name == 'bool') {
      return 'boolean';
    } else if (name == 'double' || name == 'num') {
      return 'double';
    } else if (name == 'int') {
      return 'integer';
    } else if (name == 'String') {
      return 'string';
    }
    return null;
  }

  String getSpecificationCode() {
    var mimeType = annotation?.mimeType;

    String? specTypeName;
    String? itemTypeName;
    TypeDescriptor? itemType;
    if (type.isArray) {
      specTypeName = 'array';
      itemType = type;
      itemTypeName ??= itemType.name;
    } else if (type.isDynamic) {
      specTypeName = 'object';
    } else {
      specTypeName = _getSpecTypeName(type.name);
      if (specTypeName == null) {
        specTypeName = 'object';
        itemType = type;
        itemTypeName ??= itemType.name;
      }
    }

    final required = (annotation?.required ?? false) || !nullable;
    final title = annotation?.title ?? '';
    final format = annotation?.format ?? '';

    final commonArgs = {
      if (title.isNotEmpty) 'title': title.stringLiteral(),
      if (format.isNotEmpty) 'format': format.stringLiteral(),
      if (nullable) 'nullable': 'true',
      if (required) 'required': 'true',
    }.entries.map((e) => '${e.key}: ${e.value}').join(', ');

    String spec;
    if (specTypeName == 'object') {
      final itemSpecTypeName = _getSpecTypeName(itemType!.name);
      if (itemSpecTypeName != null) {
        spec =
            'PropertySpecification.object(${name.stringLiteral()}, $commonArgs)';
      } else {
        spec =
            'PropertySpecification.object(${name.stringLiteral()}, type: $itemTypeName, $commonArgs)';
      }
    } else if (specTypeName == 'file') {
      spec =
          'PropertySpecification.file(${mimeType.stringLiteral() ?? '*/*'}, ${name.stringLiteral()}, $commonArgs)';
    } else if (specTypeName == 'array') {
      final itemSpecTypeName = _getSpecTypeName(itemType!.name);
      if (itemSpecTypeName != null) {
        spec =
            'PropertySpecification.array(${name.stringLiteral()}, items: TypeSpecification.$itemSpecTypeName(), $commonArgs)';
      } else {
        spec =
            'PropertySpecification.array(${name.stringLiteral()}, items: TypeSpecification.reference($itemTypeName), $commonArgs)';
      }
    } else {
      spec =
          'PropertySpecification.$specTypeName(${name.stringLiteral()}, $commonArgs)';
    }

    return spec;
  }
}
