import 'field_descriptor.dart';
import 'type_descriptor.dart';

abstract class WrappedTypeDescriptor implements TypeDescriptor {
  WrappedTypeDescriptor(this.typeDescr);

  final TypeDescriptor typeDescr;

  @override
  String get title => typeDescr.title;

  @override
  Iterable<FieldDescriptor> get allFields => typeDescr.allFields;

  @override
  String get deserializationExtensionCode =>
      typeDescr.deserializationExtensionCode;

  @override
  Map<String, FieldDescriptor> get fields => typeDescr.fields;

  @override
  String getDeserializer(String json) => typeDescr.getDeserializer(json);

  @override
  String getRequestReaderCode(String req) =>
      typeDescr.getRequestReaderCode(req);

  @override
  String getSerializer() => typeDescr.getSerializer();

  @override
  bool get hasConstructorDeserializer => typeDescr.hasConstructorDeserializer;

  @override
  bool get hasDeserializer => typeDescr.hasDeserializer;

  @override
  bool get hasSerializer => typeDescr.hasSerializer;

  @override
  bool get isDynamic => typeDescr.isDynamic;

  @override
  bool get isScalar => typeDescr.isScalar;

  @override
  String get name => typeDescr.name;

  @override
  String get requestExtensionCode => typeDescr.requestExtensionCode;

  @override
  String get serializationExtensionCode => typeDescr.serializationExtensionCode;

  @override
  String get specificationExtensionCode => typeDescr.specificationExtensionCode;

  @override
  List<TypeDescriptor> get superTypes => typeDescr.superTypes;
}
