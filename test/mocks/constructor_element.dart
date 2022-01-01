import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/generated/source.dart';

import 'element.dart';

class ConstructorElementMock extends ElementMock implements ConstructorElement {
  ConstructorElementMock(
      {String? displayName,
      required String name,
      this.isDefaultConstructor = false,
      List<ElementAnnotation>? metadata})
      : super(displayName: displayName ?? name, name: name, metadata: metadata);

  @override
  String get name => super.name!;

  @override
  final bool isDefaultConstructor;

  @override
  final List<ParameterElement> parameters = <ParameterElement>[];

  // NOT IMPLEMENTED

  @override
  Source get librarySource => throw UnimplementedError();

  @override
  Source get source => throw UnimplementedError();

  @override
  ConstructorElement get declaration => throw UnimplementedError();

  @override
  ClassElement get enclosingElement => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  bool get isAbstract => throw UnimplementedError();

  @override
  bool get isConst => throw UnimplementedError();

  @override
  bool get isConstantEvaluated => throw UnimplementedError();

  @override
  bool get isExternal => throw UnimplementedError();

  @override
  bool get isStatic => throw UnimplementedError();

  @override
  bool get hasImplicitReturnType => throw UnimplementedError();

  @override
  bool get isAsynchronous => throw UnimplementedError();

  @override
  bool get isFactory => throw UnimplementedError();

  @override
  bool get isGenerator => throw UnimplementedError();

  @override
  bool get isOperator => throw UnimplementedError();

  @override
  bool get isSimplyBounded => throw UnimplementedError();

  @override
  bool get isSynchronous => throw UnimplementedError();

  @override
  int? get nameEnd => throw UnimplementedError();

  @override
  int? get periodOffset => throw UnimplementedError();

  @override
  ConstructorElement? get redirectedConstructor => throw UnimplementedError();

  @override
  InterfaceType get returnType => throw UnimplementedError();

  @override
  FunctionType get type => throw UnimplementedError();

  @override
  List<TypeParameterElement> get typeParameters => throw UnimplementedError();
}
