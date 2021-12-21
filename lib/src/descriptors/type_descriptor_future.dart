import 'type_descriptor.dart';
import 'type_descriptor_wrapper.dart';

class FutureTypeDescriptor extends WrappedTypeDescriptor {
  FutureTypeDescriptor(TypeDescriptor typeDescr) : super(typeDescr);

  @override
  bool get isFuture => true;

  @override
  bool get isArray => typeDescr.isArray;
}
