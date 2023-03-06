import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/error/error.dart';

class ElementAnnotationMock implements ElementAnnotation {
  ElementAnnotationMock({this.element, this.value});

  @override
  final Element? element;

  final DartObject? value;

  @override
  DartObject? computeConstantValue() => value;

  // NOT IMPLEMENTED

  @override
  List<AnalysisError>? get constantEvaluationErrors =>
      throw UnimplementedError();

  @override
  AnalysisContext get context => throw UnimplementedError();

  @override
  bool get isAlwaysThrows => throw UnimplementedError();

  @override
  bool get isConstantEvaluated => throw UnimplementedError();

  @override
  bool get isDeprecated => throw UnimplementedError();

  @override
  bool get isDoNotStore => throw UnimplementedError();

  @override
  bool get isFactory => throw UnimplementedError();

  @override
  bool get isImmutable => throw UnimplementedError();

  @override
  bool get isInternal => throw UnimplementedError();

  @override
  bool get isIsTest => throw UnimplementedError();

  @override
  bool get isIsTestGroup => throw UnimplementedError();

  @override
  bool get isJS => throw UnimplementedError();

  @override
  bool get isLiteral => throw UnimplementedError();

  @override
  bool get isMustCallSuper => throw UnimplementedError();

  @override
  bool get isNonVirtual => throw UnimplementedError();

  @override
  bool get isOptionalTypeArgs => throw UnimplementedError();

  @override
  bool get isOverride => throw UnimplementedError();

  @override
  bool get isProtected => throw UnimplementedError();

  @override
  bool get isProxy => throw UnimplementedError();

  @override
  bool get isRequired => throw UnimplementedError();

  @override
  bool get isSealed => throw UnimplementedError();

  @override
  bool get isTarget => throw UnimplementedError();

  @override
  bool get isUseResult => throw UnimplementedError();

  @override
  bool get isVisibleForOverriding => throw UnimplementedError();

  @override
  bool get isVisibleForTemplate => throw UnimplementedError();

  @override
  bool get isVisibleForTesting => throw UnimplementedError();

  @override
  LibraryElement? get library => throw UnimplementedError();

  @override
  Source? get librarySource => throw UnimplementedError();

  @override
  Source? get source => throw UnimplementedError();

  @override
  String toSource() {
    throw UnimplementedError();
  }

  @override
  bool get isMustBeOverridden => throw UnimplementedError();

  @override
  bool get isReopen => throw UnimplementedError();
}
