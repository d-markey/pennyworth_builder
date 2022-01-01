import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:pennyworth/annotations.dart';
import 'package:source_gen/source_gen.dart';

import 'descriptors/type_loader.dart';

class RestEntityGenerator extends GeneratorForAnnotation<RestEntity> {
  RestEntityGenerator(this._loader, this._options);

  final TypeLoader _loader;
  final RestEntityOptions _options;

  @override
  Iterable<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final classElt = element;
    if (classElt is! ClassElement) return const [];
    // implementation moved to a specific method to facilitate unit tests
    return generateTypeSpecification(classElt);
  }

  Iterable<String> generateTypeSpecification(ClassElement classElt) sync* {
    final type = _loader.load(classElt.thisType)!;

    yield '// REST Entity: ${type.name}';
    yield type.specificationExtensionCode;
    if (type.autoSerialize ?? _options.autoSerialize) {
      yield type.serializationExtensionCode;
      yield type.deserializationExtensionCode;
    }
    yield type.requestExtensionCode;
  }
}

class RestEntityOptions {
  RestEntityOptions([BuilderOptions? options]) {
    var value = options?.config['auto_serialization']?.toString().toLowerCase();
    if (value != null &&
        (value == 'false' ||
            value == 'off' ||
            value == 'disable' ||
            value == '0')) {
      autoSerialize = false;
    } else if (value == null ||
        value == 'true' ||
        value == 'on' ||
        value == 'enable' ||
        value == '1') {
      autoSerialize = true;
    } else {
      log.warning(
          'Unsupported value "$value" for auto_serialization option, assuming "true"');
      autoSerialize = true;
    }
  }

  late final bool autoSerialize;
}
