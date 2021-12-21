import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'element.dart';

class FieldElementMock extends ElementMock implements FieldElement {
  FieldElementMock(
      {String? displayName,
      required String name,
      required this.type,
      List<ElementAnnotation>? metadata})
      : super(displayName: displayName ?? name, name: name, metadata: metadata);

  @override
  String get name => super.name!;

  @override
  final DartType type;

  // NOT IMPLEMENTED

  @override
  FieldElement get declaration => throw UnimplementedError();

  @override
  CompilationUnitElement get enclosingElement => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  DartObject? computeConstantValue() {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? get getter => throw UnimplementedError();

  @override
  bool get hasImplicitType => throw UnimplementedError();

  @override
  bool get hasInitializer => throw UnimplementedError();

  @override
  bool get isAbstract => throw UnimplementedError();

  @override
  bool get isConst => throw UnimplementedError();

  @override
  bool get isConstantEvaluated => throw UnimplementedError();

  @override
  bool get isCovariant => throw UnimplementedError();

  @override
  bool get isEnumConstant => throw UnimplementedError();

  @override
  bool get isExternal => throw UnimplementedError();

  @override
  bool get isFinal => throw UnimplementedError();

  @override
  bool get isLate => throw UnimplementedError();

  @override
  bool get isStatic => throw UnimplementedError();

  @override
  PropertyAccessorElement? get setter => throw UnimplementedError();
}
