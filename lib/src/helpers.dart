import 'package:analyzer/dart/element/element.dart';

extension StringConversionExt on String? {
  String? stringLiteral() =>
      (this == null) ? null : ('\'' + this!.replaceAll('\'', '\\\'') + '\'');

  String? lowerCamelCase() => (this == null)
      ? null
      : (this!.isEmpty
          ? ''
          : (this!.substring(0, 1).toLowerCase() + this!.substring(1)));

  String? upperCamelCase() => (this == null)
      ? null
      : (this!.isEmpty
          ? ''
          : (this!.substring(0, 1).toUpperCase() + this!.substring(1)));
}

extension ArgumentsExt on List<String> {
  void addArgument(ParameterElement p, String value) {
    if (p.isNamed) {
      add('${p.name}: $value');
    } else {
      add(value);
    }
  }
}
