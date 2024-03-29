import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/src/generated/source.dart';

import 'package:pennyworth/src/extensions.dart';
import 'element.dart';
import 'interface_type.dart';

class ClassElementMock extends ElementMock implements ClassElement {
  ClassElementMock(
      {required String name,
      this.unnamedConstructor,
      List<ElementAnnotation>? metadata})
      : super(name: name, metadata: metadata) {
    thisType = InterfaceTypeMock(name: name, element: this);
  }

  @override
  final List<InterfaceType> allSupertypes = [];

  @override
  final ConstructorElement? unnamedConstructor;

  @override
  final List<ConstructorElement> constructors = [];

  @override
  ConstructorElement? getNamedConstructor(String name) =>
      constructors.singleOrNull((c) => c.name == name);

  @override
  final List<FieldElement> fields = [];

  @override
  FieldElement? getField(String name) =>
      fields.singleOrNull((f) => f.name == name);

  @override
  final List<MethodElement> methods = [];

  @override
  MethodElement? getMethod(String name) =>
      methods.singleOrNull((m) => m.name == name);

  @override
  late final InterfaceType thisType;

  // NOT IMPLEMENTED

  @override
  Element get declaration => throw UnimplementedError();

  @override
  CompilationUnitElement get enclosingElement => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  Source get librarySource => throw UnimplementedError();

  @override
  Source get source => throw UnimplementedError();

  @override
  List<PropertyAccessorElement> get accessors => throw UnimplementedError();

  @override
  PropertyAccessorElement? getGetter(String name) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? getSetter(String name) {
    throw UnimplementedError();
  }

  @override
  bool get hasNonFinalField => throw UnimplementedError();

  @override
  InterfaceType instantiate(
      {required List<DartType> typeArguments,
      required NullabilitySuffix nullabilitySuffix}) {
    throw UnimplementedError();
  }

  @override
  List<InterfaceType> get interfaces => throw UnimplementedError();

  @override
  bool get isAbstract => throw UnimplementedError();

  @override
  bool get isDartCoreObject => throw UnimplementedError();

  @override
  bool get isMixinApplication => throw UnimplementedError();

  @override
  bool get isSimplyBounded => throw UnimplementedError();

  @override
  bool get isValidMixin => throw UnimplementedError();

  @override
  MethodElement? lookUpConcreteMethod(
      String methodName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpGetter(
      String getterName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpInheritedConcreteGetter(
      String getterName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpInheritedConcreteMethod(
      String methodName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpInheritedConcreteSetter(
      String setterName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpInheritedMethod(
      String methodName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpMethod(String methodName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpSetter(
      String setterName, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  List<InterfaceType> get mixins => throw UnimplementedError();

  @override
  List<InterfaceType> get superclassConstraints => throw UnimplementedError();

  @override
  InterfaceType? get supertype => throw UnimplementedError();

  @override
  List<TypeParameterElement> get typeParameters => throw UnimplementedError();

  @override
  ClassAugmentationElement? get augmentation => throw UnimplementedError();

  @override
  AugmentedClassElement get augmented => throw UnimplementedError();

  @override
  List<Element> get children => throw UnimplementedError();

  @override
  CompilationUnitElement get enclosingElement3 => throw UnimplementedError();

  @override
  bool get hasMustBeOverridden => throw UnimplementedError();

  @override
  bool get hasReopen => throw UnimplementedError();

  @override
  bool isAccessibleIn2(LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  bool get isBase => throw UnimplementedError();

  @override
  bool get isConstructable => throw UnimplementedError();

  @override
  bool get isDartCoreEnum => throw UnimplementedError();

  @override
  bool get isExhaustive => throw UnimplementedError();

  @override
  bool isExtendableIn(LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  bool get isFinal => throw UnimplementedError();

  @override
  bool isImplementableIn(LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  bool get isInterface => throw UnimplementedError();

  @override
  bool isMixableIn(LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  bool get isMixinClass => throw UnimplementedError();

  @override
  bool get isSealed => throw UnimplementedError();
}
