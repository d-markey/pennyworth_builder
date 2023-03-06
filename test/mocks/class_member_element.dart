import 'package:analyzer/dart/element/element.dart';

import 'element.dart';

class ClassMemberElementMock extends ElementMock implements ClassMemberElement {
  ClassMemberElementMock(
      {required String name, List<ElementAnnotation>? metadata})
      : super(name: name, metadata: metadata);

  // NOT IMPLEMENTED

  @override
  Element get enclosingElement3 => throw UnimplementedError();

  @override
  FieldElement get declaration => throw UnimplementedError();

  @override
  CompilationUnitElement get enclosingElement => throw UnimplementedError();

  @override
  LibraryElement get library => throw UnimplementedError();

  @override
  bool get isStatic => throw UnimplementedError();
}
