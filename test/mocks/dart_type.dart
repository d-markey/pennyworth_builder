import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/type_visitor.dart';

class DartTypeMock implements DartType {
  const DartTypeMock(
      {required this.name,
      this.element,
      this.isDartAsyncFuture = false,
      this.isDartAsyncFutureOr = false,
      this.isDartCoreBool = false,
      this.isDartCoreDouble = false,
      this.isDartCoreFunction = false,
      this.isDartCoreInt = false,
      this.isDartCoreIterable = false,
      this.isDartCoreList = false,
      this.isDartCoreMap = false,
      this.isDartCoreNull = false,
      this.isDartCoreNum = false,
      this.isDartCoreObject = false,
      this.isDartCoreSet = false,
      this.isDartCoreString = false,
      this.isDartCoreSymbol = false,
      this.isDynamic = false,
      this.isVoid = false,
      this.nullabilitySuffix = NullabilitySuffix.none});

  static const stringType =
      DartTypeMock(name: 'String', isDartCoreString: true);

  static const booleanType = DartTypeMock(name: 'bool', isDartCoreBool: true);

  static const nullableBooleanType = DartTypeMock(
      name: 'bool',
      isDartCoreBool: true,
      nullabilitySuffix: NullabilitySuffix.question);

  static const listDartObjectType =
      DartTypeMock(name: 'List<DartObject>', isDartCoreList: true);

  @override
  final Element? element;

  @override
  String getDisplayString({required bool withNullability}) =>
      '$name${withNullability ? '?' : ''}';

  @override
  final bool isDartAsyncFuture;

  @override
  final bool isDartAsyncFutureOr;

  @override
  final bool isDartCoreBool;

  @override
  final bool isDartCoreDouble;

  @override
  final bool isDartCoreFunction;

  @override
  final bool isDartCoreInt;

  @override
  final bool isDartCoreIterable;

  @override
  final bool isDartCoreList;

  @override
  final bool isDartCoreMap;

  @override
  final bool isDartCoreNull;

  @override
  final bool isDartCoreNum;

  @override
  final bool isDartCoreObject;

  @override
  final bool isDartCoreSet;

  @override
  final bool isDartCoreString;

  @override
  final bool isDartCoreSymbol;

  @override
  final bool isDynamic;

  @override
  final bool isVoid;

  @override
  final String name;

  @override
  final NullabilitySuffix nullabilitySuffix;

  // NOT IMPLEMENTED

  @override
  R accept<R>(TypeVisitor<R> visitor) {
    throw UnimplementedError();
  }

  @override
  R acceptWithArgument<R, A>(
      TypeVisitorWithArgument<R, A> visitor, A argument) {
    throw UnimplementedError();
  }

  @override
  InstantiatedTypeAliasElement? get alias => throw UnimplementedError();

  @override
  InterfaceType? asInstanceOf(InterfaceElement element) {
    throw UnimplementedError();
  }

  @override
  bool get isBottom => throw UnimplementedError();

  @override
  DartType resolveToBound(DartType objectType) {
    throw UnimplementedError();
  }

  @override
  Element? get element2 => throw UnimplementedError();

  @override
  bool get isDartAsyncStream => throw UnimplementedError();

  @override
  bool get isDartCoreEnum => throw UnimplementedError();

  @override
  bool get isDartCoreRecord => throw UnimplementedError();
}
