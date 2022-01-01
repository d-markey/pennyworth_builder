import 'type_descriptor.dart';
import 'type_descriptor_wrapper.dart';

class ArrayTypeDescriptor extends WrappedTypeDescriptor {
  ArrayTypeDescriptor(TypeDescriptor typeDescr) : super(typeDescr);

  @override
  bool? get autoSerialize => typeDescr.autoSerialize;

  @override
  bool get isFuture => typeDescr.isFuture;

  @override
  bool get isArray => true;
}
