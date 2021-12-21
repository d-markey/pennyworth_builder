import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import '../annotations/rest_field_annotation.dart';
import 'type_descriptor.dart';
import 'field_descriptor.dart';
import 'type_descriptor_array.dart';
import 'type_descriptor_future.dart';

class TypeLoader {
  final Map<String, TypeDescriptor> _cache = {};

  Iterable<TypeDescriptor> get types => _cache.values;

  TypeDescriptor? load(DartType? type,
      {bool isArray = false, bool isFuture = false}) {
    if (type == null || type.isVoid || type.isDartCoreNull) return null;
    final key = type.getDisplayString(withNullability: false);
    var spec = _cache[key];
    if (spec != null) return spec;
    if (type.isDartCoreList || type.isDartCoreIterable) {
      final typeArgs = (type as InterfaceType).typeArguments;
      if (typeArgs.length == 1 &&
          (typeArgs.single.isDynamic ||
              typeArgs.single.element is ClassElement)) {
        final descr = load(typeArgs.single);
        if (descr != null) {
          spec = ArrayTypeDescriptor(descr);
          _cache[key] = spec;
        }
      }
      return spec;
    } else if (type.isDartAsyncFuture || type.isDartAsyncFutureOr) {
      final typeArgs = (type as InterfaceType).typeArguments;
      if (typeArgs.length == 1 &&
          (typeArgs.single.isDynamic ||
              typeArgs.single.element is ClassElement)) {
        final descr = load(typeArgs.single);
        if (descr != null) {
          spec = FutureTypeDescriptor(descr);
          _cache[key] = spec;
        }
      }
      return spec;
    } else if (type.isScalar || type.isDynamic) {
      spec = TypeDescriptor(type, isArray: false, isFuture: false);
      _cache[key] = spec;
      return spec;
    } else {
      final spec = TypeDescriptor(type, isArray: isArray, isFuture: isFuture);
      _cache[key] = spec;
      final classElt = type.element as ClassElement;
      for (var supertype
          in classElt.allSupertypes.where((s) => !s.isDartCoreObject)) {
        final superspec = load(supertype);
        if (superspec != null) {
          spec.superTypes.add(superspec);
        }
      }
      final fields = classElt.fields.where((f) => !f.name.startsWith('_'));
      for (var f in fields.where((f) =>
          f.type.isDynamic ||
          f.type.isScalar ||
          f.type.element is ClassElement)) {
        final fieldAnnotation = RestFieldAnnotation.load(f);
        if (fieldAnnotation == null || !fieldAnnotation.ignored) {
          final fieldType = load(f.type);
          if (fieldType != null) {
            final field = FieldDescriptor(f, fieldType, fieldAnnotation);
            spec.fields[field.name] = field;
          }
        }
      }
      return spec;
    }
  }
}
