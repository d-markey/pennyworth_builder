import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/src/generated/source.dart';

import 'element.dart';

class ConstructorElementMock extends ElementMock implements ConstructorElement {
  ConstructorElementMock(
      {required String name,
      this.isDefaultConstructor = false,
      List<ElementAnnotation>? metadata})
      : super(name: name, metadata: metadata);

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

  @override
  ConstructorAugmentationElement? get augmentation =>
      throw UnimplementedError();

  @override
  List<Element> get children => throw UnimplementedError();

  @override
  InterfaceElement get enclosingElement3 => throw UnimplementedError();

  @override
  bool get hasMustBeOverridden => throw UnimplementedError();

  @override
  bool get hasReopen => throw UnimplementedError();

  @override
  bool isAccessibleIn2(LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  bool get isGenerative => throw UnimplementedError();
}
