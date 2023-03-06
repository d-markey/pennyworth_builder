import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';

import 'dart_type.dart';

class ParameterizedTypeMock extends DartTypeMock implements ParameterizedType {
  const ParameterizedTypeMock(
      {required String name,
      this.typeArguments = const [],
      Element? element,
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
      NullabilitySuffix nullabilitySuffix = NullabilitySuffix.none})
      : super(
            name: name,
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
            nullabilitySuffix: nullabilitySuffix);

  @override
  final List<DartType> typeArguments;
}
