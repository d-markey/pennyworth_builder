import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/element.dart';

import 'dart_type.dart';

class DartObjectMock implements DartObject {
  DartObjectMock({this.value, this.type, Map<String, DartObject>? fields}) {
    if (fields != null) this.fields.addEntries(fields.entries);
  }

  DartObjectMock.value(this.type, this.value);

  DartObjectMock.bool(this.value) : type = DartTypeMock.booleanType;
  DartObjectMock.string(this.value) : type = DartTypeMock.stringType;
  DartObjectMock.list(this.value) : type = DartTypeMock.listDartObjectType;

  final Map<String, DartObject> fields = {};

  final dynamic value;

  @override
  DartObject? getField(String name) => fields[name];

  @override
  bool? toBoolValue() => _toValue<bool>();

  @override
  String? toStringValue() => _toValue<String>();

  @override
  DartType? toTypeValue() => _toValue<DartType>();

  @override
  List<DartObject>? toListValue() => _toValue<List<DartObject>>();

  T? _toValue<T>() => (value is T) ? (value as T) : null;

  @override
  final DartType? type;

  // NOT IMPLEMENTED

  @override
  bool get hasKnownValue => throw UnimplementedError();

  @override
  bool get isNull => throw UnimplementedError();

  @override
  double? toDoubleValue() {
    throw UnimplementedError();
  }

  @override
  ExecutableElement? toFunctionValue() {
    throw UnimplementedError();
  }

  @override
  int? toIntValue() {
    throw UnimplementedError();
  }

  @override
  Map<DartObject?, DartObject?>? toMapValue() {
    throw UnimplementedError();
  }

  @override
  Set<DartObject>? toSetValue() {
    throw UnimplementedError();
  }

  @override
  String? toSymbolValue() {
    throw UnimplementedError();
  }

  @override
  VariableElement? get variable => throw UnimplementedError();
}
