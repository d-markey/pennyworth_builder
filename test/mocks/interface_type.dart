import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

import 'dart_type.dart';

class InterfaceTypeMock extends DartTypeMock implements InterfaceType {
  InterfaceTypeMock(
      {required String displayName,
      required ClassElement element,
      bool isDartAsyncFuture = false,
      bool isDartAsyncFutureOr = false,
      bool isDartCoreBool = false,
      bool isDartCoreDouble = false,
      bool isDartCoreFunction = false,
      bool isDartCoreInt = false,
      bool isDartCoreIterable = false,
      bool isDartCoreList = false,
      bool isDartCoreMap = false,
      bool isDartCoreNull = false,
      bool isDartCoreNum = false,
      bool isDartCoreObject = false,
      bool isDartCoreSet = false,
      bool isDartCoreString = false,
      bool isDartCoreSymbol = false,
      bool isDynamic = false,
      bool isVoid = false,
      String? name,
      NullabilitySuffix nullabilitySuffix = NullabilitySuffix.none})
      : super(
            displayName: displayName,
            element: element,
            isDartAsyncFuture: isDartAsyncFuture,
            isDartAsyncFutureOr: isDartAsyncFutureOr,
            isDartCoreBool: isDartCoreBool,
            isDartCoreDouble: isDartCoreDouble,
            isDartCoreFunction: isDartCoreFunction,
            isDartCoreInt: isDartCoreInt,
            isDartCoreIterable: isDartCoreIterable,
            isDartCoreList: isDartCoreList,
            isDartCoreMap: isDartCoreMap,
            isDartCoreNull: isDartCoreNull,
            isDartCoreNum: isDartCoreNum,
            isDartCoreObject: isDartCoreObject,
            isDartCoreSet: isDartCoreSet,
            isDartCoreString: isDartCoreString,
            isDartCoreSymbol: isDartCoreSymbol,
            isDynamic: isDynamic,
            isVoid: isVoid,
            name: name,
            nullabilitySuffix: nullabilitySuffix);

  @override
  List<InterfaceType> get allSupertypes => element.allSupertypes;

  @override
  ClassElement get element => super.element as ClassElement;

  @override
  List<PropertyAccessorElement> get accessors => element.accessors;

  @override
  List<ConstructorElement> get constructors => element.constructors;

  @override
  List<MethodElement> get methods => element.methods;

  @override
  PropertyAccessorElement? getGetter(String name) => element.getGetter(name);

  @override
  MethodElement? getMethod(String name) => element.getMethod(name);

  @override
  PropertyAccessorElement? getSetter(String name) => element.getSetter(name);

  @override
  PropertyAccessorElement? lookUpGetter(String name, LibraryElement library) =>
      element.lookUpGetter(name, library);

  @override
  MethodElement? lookUpMethod(String name, LibraryElement library) =>
      element.lookUpMethod(name, library);

  @override
  PropertyAccessorElement? lookUpSetter(String name, LibraryElement library) =>
      element.lookUpSetter(name, library);

  // NOT IMPLEMENTED

  @override
  ConstructorElement? lookUpConstructor(String? name, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpGetter2(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpGetterInSuperclass(
      String name, LibraryElement? library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpInheritedGetter(String name,
      {LibraryElement? library, bool thisType = true}) {
    throw UnimplementedError();
  }

  @override
  ExecutableElement? lookUpInheritedGetterOrMethod(String name,
      {LibraryElement? library}) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpInheritedMethod(String name,
      {LibraryElement? library, bool thisType = true}) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpInheritedSetter(String name,
      {LibraryElement? library, bool thisType = true}) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpMethod2(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    throw UnimplementedError();
  }

  @override
  MethodElement? lookUpMethodInSuperclass(String name, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpSetter2(String name, LibraryElement library,
      {bool concrete = false,
      bool inherited = false,
      bool recoveryStatic = false}) {
    throw UnimplementedError();
  }

  @override
  PropertyAccessorElement? lookUpSetterInSuperclass(
      String name, LibraryElement library) {
    throw UnimplementedError();
  }

  @override
  List<InterfaceType> get interfaces => throw UnimplementedError();

  @override
  List<InterfaceType> get mixins => throw UnimplementedError();

  @override
  InterfaceType? get superclass => throw UnimplementedError();

  @override
  List<InterfaceType> get superclassConstraints => throw UnimplementedError();

  @override
  List<DartType> get typeArguments => throw UnimplementedError();
}
