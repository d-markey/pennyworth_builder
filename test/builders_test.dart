import 'package:test/test.dart';

import 'package:pennyworth/annotations.dart';

import 'package:pennyworth_builder/src/annotations/annotation_reader.dart';
import 'package:pennyworth_builder/src/descriptors/type_loader.dart';
import 'package:pennyworth_builder/src/rest_entity_generator.dart';
import 'package:pennyworth_builder/src/extensions.dart';

import 'mocks/class_element.dart';
import 'mocks/constructor_element.dart';
import 'mocks/dart_object.dart';
import 'mocks/dart_type.dart';
import 'mocks/element.dart';
import 'mocks/element_annotation.dart';
import 'mocks/field_element.dart';
import 'mocks/parameter_element.dart';

void main() {
  group('Annotations', () {
    test('Can read a single annotation', () {
      final classtElt =
          ElementMock(displayName: 'Dto', name: 'Dto', metadata: []);

      classtElt.metadata.addAll([
        ElementAnnotationMock(
            element: classtElt,
            value: DartObjectMock(fields: {
              'nullable': DartObjectMock.bool(true),
              'title': DartObjectMock.string('Test entity')
            }, type: DartTypeMock(displayName: 'RestEntity'))),
      ]);

      final reader = AnnotationReader<RestEntity>(classtElt);
      expect(reader.isSet('nullable'), isTrue);
      expect(reader.getString('title'), equals('Test entity'));
    });

    test('Can read multiple annotations', () {
      final classtElt =
          ElementMock(displayName: 'Dto', name: 'Dto', metadata: []);

      classtElt.metadata.addAll([
        ElementAnnotationMock(
            element: classtElt,
            value: DartObjectMock(fields: {
              'nullable': DartObjectMock.bool(true),
              'title': DartObjectMock.string('Test entity')
            }, type: DartTypeMock(displayName: 'RestEntity'))),
        ElementAnnotationMock(
            element: classtElt,
            value: DartObjectMock(fields: {
              'required': DartObjectMock.bool(false),
            }, type: DartTypeMock(displayName: 'RestEntity'))),
        ElementAnnotationMock(
            element: classtElt,
            value: DartObjectMock(fields: {
              'tags': DartObjectMock.list([
                DartObjectMock.string('Test 1'),
                DartObjectMock.string('Test 2'),
              ]),
            }, type: DartTypeMock(displayName: 'RestEntity'))),
      ]);

      final reader = AnnotationReader<RestEntity>(classtElt);
      expect(reader.isSet('nullable'), isTrue);
      expect(reader.getBoolean('required'), isFalse);
      expect(reader.getString('title'), equals('Test entity'));
      expect(
          reader
              .getList('tags')
              ?.map((t) => t.toStringValue()?.trim())
              .whereNotEmpty(),
          equals(['Test 1', 'Test 2']));
    });
  });

  group('Code Generation - Entities', () {
    test('Type specification (no fields)', () {
      final classtElt = ClassElementMock(
          displayName: 'RestData', name: 'RestData', metadata: []);

      classtElt.metadata.addAll([
        ElementAnnotationMock(
            element: classtElt,
            value: DartObjectMock(
                fields: {'title': DartObjectMock.string('Test entity')},
                type: DartTypeMock(displayName: 'RestEntity'))),
        ElementAnnotationMock(
            element: classtElt,
            value: DartObjectMock(fields: {
              'tags': DartObjectMock.list([
                DartObjectMock.string('Test 1'),
                DartObjectMock.string('Test 2'),
              ]),
            }, type: DartTypeMock(displayName: 'RestEntity'))),
      ]);

      final typeLoader = TypeLoader();
      final generator = RestEntityGenerator(typeLoader, RestEntityOptions());

      final code = generator.generateTypeSpecification(classtElt).toList();

      expect(code.length, equals(5));

      expect(code[0], equals('// REST Entity: RestData'));
      expect(code[1],
          contains('extension RestDataRegistrationExt on OpenApiService'));
      expect(
          code[2], contains('extension RestDataSerializationExt on RestData'));
      expect(
          code[3],
          contains(
              'extension RestDataDeserializationExt on Map<String, dynamic>'));
      expect(code[4], contains('extension RestDataRequestExt on HttpRequest'));
    });

    test('Type specification (no serialization)', () {
      final classtElt = ClassElementMock(
          displayName: 'RestData', name: 'RestData', metadata: []);

      classtElt.metadata.addAll([
        ElementAnnotationMock(
            element: classtElt,
            value: DartObjectMock(
                fields: {'title': DartObjectMock.string('Test entity')},
                type: DartTypeMock(displayName: 'RestEntity'))),
        ElementAnnotationMock(
            element: classtElt,
            value: DartObjectMock(fields: {
              'autoSerialize': DartObjectMock.bool(false),
            }, type: DartTypeMock(displayName: 'RestEntity'))),
        ElementAnnotationMock(
            element: classtElt,
            value: DartObjectMock(fields: {
              'tags': DartObjectMock.list([
                DartObjectMock.string('Test 1'),
                DartObjectMock.string('Test 2'),
              ]),
            }, type: DartTypeMock(displayName: 'RestEntity'))),
      ]);

      final typeLoader = TypeLoader();
      final generator = RestEntityGenerator(typeLoader, RestEntityOptions());

      final code = generator.generateTypeSpecification(classtElt).toList();

      expect(code.length, equals(3));

      expect(code[0], equals('// REST Entity: RestData'));
      expect(code[1],
          contains('extension RestDataRegistrationExt on OpenApiService'));
      expect(code[2], contains('extension RestDataRequestExt on HttpRequest'));
    });

    test('Type specification', () {
      final unnamedCtor =
          ConstructorElementMock(name: 'RestData', isDefaultConstructor: true);
      unnamedCtor.parameters.addAll([
        ParameterElementMock(name: 'identifier', type: DartTypeMock.stringType),
        ParameterElementMock(
            name: 'selected',
            type: DartTypeMock.nullableBooleanType,
            isNamed: true),
      ]);

      final classtElt = ClassElementMock(
          displayName: 'RestData',
          name: 'RestData',
          metadata: [],
          unnamedConstructor: unnamedCtor);

      classtElt.metadata.addAll([
        ElementAnnotationMock(
            element: classtElt,
            value: DartObjectMock(
                fields: {'title': DartObjectMock.string('Test entity')},
                type: DartTypeMock(displayName: 'RestEntity'))),
        ElementAnnotationMock(
            element: classtElt,
            value: DartObjectMock(fields: {
              'tags': DartObjectMock.list([
                DartObjectMock.string('Test 1'),
                DartObjectMock.string('Test 2'),
              ]),
            }, type: DartTypeMock(displayName: 'RestEntity'))),
      ]);

      classtElt.fields.addAll([
        FieldElementMock(name: 'identifier', type: DartTypeMock.stringType),
        FieldElementMock(
            name: 'selected', type: DartTypeMock.nullableBooleanType)
      ]);

      final typeLoader = TypeLoader();
      final generator = RestEntityGenerator(typeLoader, RestEntityOptions());

      final code = generator.generateTypeSpecification(classtElt).toList();

      expect(code.length, equals(5));

      expect(code[0], equals('// REST Entity: RestData'));

      expect(code[1],
          contains('extension RestDataRegistrationExt on OpenApiService'));
      expect(code[1], contains('\'identifier\''));
      expect(code[1], contains('\'selected\''));
      expect(code[1], contains('nullable: true'));

      expect(
          code[2], contains('extension RestDataSerializationExt on RestData'));
      expect(code[2], contains('\'identifier\': identifier'));
      expect(code[3],
          predicate<String>((c) => !c.contains('if (identifier != null)')));
      expect(code[2], contains('if (selected != null) \'selected\': selected'));

      expect(
          code[3],
          contains(
              'extension RestDataDeserializationExt on Map<String, dynamic>'));
      expect(code[3], contains('[\'identifier\']'));
      expect(code[3], predicate<String>((c) => !c.contains('identifier:')));
      expect(code[3], contains('selected:'));
      expect(code[3], contains('\'selected\''));

      expect(code[4], contains('extension RestDataRequestExt on HttpRequest'));
    });
  });
}
