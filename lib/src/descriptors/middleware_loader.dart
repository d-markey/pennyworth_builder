import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

import '../helpers.dart';

class MiddlewareLoader {
  static String load(List<List<DartObject>>? middleware) {
    if (middleware == null || middleware.isEmpty) {
      return 'const <AlfredMiddleware>[]';
    }
    final s = <String>[];
    s.add('[ ');
    for (var m in middleware) {
      final classElt = m[0].toTypeValue()!.element as ClassElement;
      if (m.length == 1) {
        if (classElt.getGetter('instance') == null ||
            classElt.getField('instance') == null) {
          log.warning(
              'Missing instance getter or field for Singleton middleware ${classElt.name}');
        } else {
          s.add('${classElt.name}.instance,');
        }
      } else {
        final args =
            m.skip(1).map((s) => (s.toStringValue() ?? '').stringLiteral());
        final getMethod = classElt.getMethod('get');
        if (getMethod == null || getMethod.parameters.length != args.length) {
          log.warning('Parameters mismatch for middleware ${classElt.name}');
        } else {
          s.add('${classElt.name}.get(${args.join(', ')}), ');
        }
      }
    }
    s.add(']');
    return s.join('\n');
  }
}
