import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/generated/utilities_dart.dart';

import 'element.dart';

class ParameterElementMock extends ElementMock implements ParameterElement {
  ParameterElementMock(
      {required String name,
      required this.type,
      this.isNamed = false,
      List<ElementAnnotation>? metadata})
      : super(name: name, metadata: metadata);

  @override
  final bool isNamed;

  @override
  final DartType type;

  // NOT IMPLEMENTED

  @override
  ParameterElement get declaration => throw UnimplementedError();

  @override
  CompilationUnitElement get enclosingElement => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  DartObject? computeConstantValue() {
    throw UnimplementedError();
  }

  @override
  bool get hasImplicitType => throw UnimplementedError();

  @override
  bool get isConst => throw UnimplementedError();

  @override
  bool get isConstantEvaluated => throw UnimplementedError();

  @override
  bool get isCovariant => throw UnimplementedError();

  @override
  bool get isFinal => throw UnimplementedError();

  @override
  bool get isLate => throw UnimplementedError();

  @override
  bool get isStatic => throw UnimplementedError();

  @override
  void appendToWithoutDelimiters(StringBuffer buffer,
          {bool withNullability = false}) =>
      throw UnimplementedError();

  @override
  String? get defaultValueCode => throw UnimplementedError();

  @override
  bool get hasDefaultValue => throw UnimplementedError();

  @override
  bool get isInitializingFormal => throw UnimplementedError();

  @override
  bool get isOptional => throw UnimplementedError();

  @override
  bool get isOptionalNamed => throw UnimplementedError();

  @override
  bool get isOptionalPositional => throw UnimplementedError();

  @override
  bool get isPositional => throw UnimplementedError();

  @override
  bool get isRequiredNamed => throw UnimplementedError();

  @override
  bool get isRequiredPositional => throw UnimplementedError();

  @override
  ParameterKind get parameterKind => throw UnimplementedError();

  @override
  List<ParameterElement> get parameters => throw UnimplementedError();

  @override
  List<TypeParameterElement> get typeParameters => throw UnimplementedError();

  @override
  bool get isRequired => throw UnimplementedError();

  @override
  bool get isSuperFormal => throw UnimplementedError();
}
