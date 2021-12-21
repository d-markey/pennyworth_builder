import 'type_descriptor.dart';

class OperationDescriptor {
  OperationDescriptor(this.input, this.output, this.code);

  final TypeDescriptor? input;
  final TypeDescriptor? output;
  final String code;
}
