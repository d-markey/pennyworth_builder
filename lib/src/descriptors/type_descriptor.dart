import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';

import '../extensions.dart';
import '../annotations/rest_entity_annotation.dart';
import '../helpers.dart';
import 'field_descriptor.dart';

extension TypePropExt on DartType {
  bool get isScalar => (isDartCoreBool ||
      isDartCoreDouble ||
      isDartCoreInt ||
      isDartCoreNum ||
      isDartCoreDateTime ||
      isDartCoreString);

  bool get isDartCoreDateTime =>
      (getDisplayString(withNullability: false).toLowerCase() == 'datetime');

  bool get isJsonCompatibleType =>
      isScalar || isDynamic || isDartCoreMap || isDartCoreList;
}

class TypeDescriptor {
  TypeDescriptor(DartType type, {required this.isArray, required this.isFuture})
      : name = type.getDisplayString(withNullability: false),
        isDateTime = type.isDartCoreDateTime,
        isScalar = type.isScalar,
        isDynamic = type.isDynamic {
    final classElt = type.element;
    if (classElt is ClassElement) {
      final annotation = RestEntityAnnotation.load(classElt);
      _title = annotation?.title ?? '';
      _autoSerialize = annotation?.autoSerialize;
      _initSerializer(classElt);
      _initDeserializer(classElt);
      _initUnnamedConstructor(classElt);
    }
  }

  void _initSerializer(ClassElement elt) {
    final serializer = elt.getMethod('toJson') ?? elt.getMethod('json');
    if (serializer != null) {
      _serializer = serializer.name;
      if (!serializer.returnType.isJsonCompatibleType) {
        log.info(
            '${elt.name}: found $serializer for serialization, but the return type ${serializer.returnType} is not JSON-compatible');
      }
      if (serializer.parameters.isNotEmpty) {
        log.info(
            '${elt.name}: found $serializer for serialization, but the method expects some parameters');
      }
    }
  }

  void _initDeserializer(ClassElement elt) {
    final deserializer =
        elt.getMethod('fromJson') ?? elt.getNamedConstructor('fromJson');
    if (deserializer != null) {
      _deserializer = deserializer.name;
      if (deserializer is MethodElement && !deserializer.isStatic) {
        log.info(
            '${elt.name}: found $deserializer for deserialization, but the method is not static');
      }
      if (deserializer.parameters.length != 1) {
        log.info(
            '${elt.name}: found $deserializer for deserialization, but it expects ${deserializer.parameters.length} input parameters instead of 1');
      }
      if (!deserializer.parameters.first.type.isJsonCompatibleType) {
        log.info(
            '${elt.name}: found $deserializer for deserialization, but the parameter type ${deserializer.parameters.first.type} is not JSON-compatible');
      }
    }
  }

  void _initUnnamedConstructor(ClassElement elt) {
    _unnamedConstructorParams = elt.unnamedConstructor?.parameters;
  }

  late final String _title;
  late final bool? _autoSerialize;

  String get title => _title;
  bool? get autoSerialize => _autoSerialize;

  final String name;

  final bool isArray;
  final bool isFuture;
  final bool isScalar;
  final bool isDateTime;
  final bool isDynamic;

  String? _serializer;
  String? _deserializer;
  List<ParameterElement>? _unnamedConstructorParams;

  bool get hasSerializer => (_serializer != null);

  String getSerializer() => '${_serializer ?? 'autoSerialize'}()';

  bool get hasDeserializer => (_deserializer != null);

  String getDeserializer(String json) => (_deserializer != null)
      ? '$name.$_deserializer($json)'
      : '$json.autoDeserialize${name.upperCamelCase()}()';

  bool get hasConstructorDeserializer => (_unnamedConstructorParams != null);

  final List<TypeDescriptor> superTypes = <TypeDescriptor>[];
  final Map<String, FieldDescriptor> fields = <String, FieldDescriptor>{};

  Iterable<FieldDescriptor> get allFields {
    final fieldNames =
        fields.keys.followedBy(superTypes.expand((s) => s.fields.keys));
    return fieldNames.map(_getField).whereNotNull();
  }

  FieldDescriptor? _getField(String name) {
    var field = fields[name];
    if (field != null) return field;
    for (var s in superTypes) {
      field = s._getField(name);
      if (field != null) return field;
    }
    return null;
  }

  @override
  String toString() => (isArray
      ? '$name[]'
      : isFuture
          ? '$name>>'
          : name);

  String get serializationExtensionCode {
    return '''
extension ${name.upperCamelCase()}SerializationExt on $name {
  Map<String, dynamic> autoSerialize() =>
    <String, dynamic>{
    ${allFields.map((f) => (f.annotation?.required ?? !f.nullable) ? '${f.name.stringLiteral()}: ${f.getSerializerCode()},' : 'if (${f.name} != null) ${f.name.stringLiteral()}: ${f.getSerializerCode()},').join()}
    };
}''';
  }

  String get deserializationExtensionCode {
    if (_unnamedConstructorParams != null) {
      final fieldValues = Map<String, String>.fromEntries(allFields
          .map((f) => MapEntry(f.name, f.getDeserializerCode('this'))));
      final args = <String>[];
      for (var p in _unnamedConstructorParams!) {
        final value = fieldValues[p.name];
        if (value != null) {
          args.addArgument(p, value);
        }
      }
      return '''
extension ${name.upperCamelCase()}DeserializationExt on Map<String, dynamic> {
  $name autoDeserialize${name.upperCamelCase()}() {
    return $name(${args.join(', ')});
  }
}
      ''';
    } else {
      return '''
extension ${name.upperCamelCase()}DeserializationExt on Map<String, dynamic> {
  $name autoDeserialize${name.upperCamelCase()}() {
    throw Exception('Class $name has no unnamed constructor');
  }
}
      ''';
    }
  }

  String get requestExtensionCode {
    return '''
extension ${name.upperCamelCase()}RequestExt on HttpRequest {
  Future<$name> get${name.upperCamelCase()}() async {
    final body = await bodyAsJsonMap;
    return ${getDeserializer('body')};
  }

  Future<List<$name>> getListOf${name.upperCamelCase()}() async {
    final body = await bodyAsJsonList;
    return body.map((item) => ${getDeserializer('(item as Map<String, dynamic>)')}).toList();
  }
}
    ''';
  }

  String get specificationExtensionCode {
    final args = {if (title.isNotEmpty) 'title': title.stringLiteral()};
    final listArgs = {
      if (title.isNotEmpty) 'title': '$title (array)'.stringLiteral()
    };

    return '''
extension ${name.upperCamelCase()}RegistrationExt on OpenApiService {
  void register${name.upperCamelCase()}() {
    registerTypeSpecification<$name>(
      TypeSpecification.object(${args.entries.map((e) => '${e.key}: ${e.value}').join(', ')})
        ${allFields.map((f) => '.addProperty(${f.getSpecificationCode()})').join('\n')}
    );
    registerTypeSpecification<List<$name>>(
      TypeSpecification.array(items: TypeSpecification.object(type: $name), ${listArgs.entries.map((e) => '${e.key}: ${e.value}').join(', ')})
    );
  }
}
''';
  }

  String getRequestReaderCode(String req) {
    if (isArray) {
      return '$req.getListOf${name.upperCamelCase()}()';
    } else {
      return '$req.get${name.upperCamelCase()}()';
    }
  }
}
