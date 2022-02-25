import 'type_descriptor.dart';
import 'type_descriptor_wrapper.dart';

class FutureTypeDescriptor extends WrappedTypeDescriptor {
  FutureTypeDescriptor(TypeDescriptor typeDescr) : super(typeDescr);

  @override
  bool get isDateTime => typeDescr.isDateTime;

  @override
  bool? get autoSerialize => typeDescr.autoSerialize;

  @override
  bool get isFuture => true;

  @override
  bool get isArray => typeDescr.isArray;
}
