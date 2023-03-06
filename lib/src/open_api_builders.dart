import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'descriptors/operation_loader.dart';
import 'descriptors/type_loader.dart';
import 'rest_entity_generator.dart';
import 'rest_service_generator.dart';

final _sharedTypeLoader = TypeLoader();

Builder restEntityBuilder(BuilderOptions options) {
  log.warning('restEntityBuilder options = $options');
  final restEntityOptions = RestEntityOptions(options);
  return SharedPartBuilder(
      [RestEntityGenerator(_sharedTypeLoader, restEntityOptions)], 'dto');
}

Builder restServiceBuilder(BuilderOptions options) {
  log.warning('restServiceBuilder options = $options');
  final operationLoader = OperationLoader(_sharedTypeLoader);
  final restServiceOptions = RestServiceOptions(options);
  return SharedPartBuilder(
      [RestServiceGenerator(operationLoader, restServiceOptions)], 'svc');
}
