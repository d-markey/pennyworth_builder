import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'descriptors/operation_loader.dart';
import 'descriptors/type_loader.dart';
import 'rest_entity_generator.dart';
import 'rest_service_generator.dart';

Builder restEntityBuilder(BuilderOptions options) {
  log.warning('restEntityBuilder options = $options');
  final typeLoader = TypeLoader();
  final restEntityOptions = RestEntityOptions(options);
  return SharedPartBuilder(
      [RestEntityGenerator(typeLoader, restEntityOptions)], 'dto');
}

Builder restServiceBuilder(BuilderOptions options) {
  log.warning('restServiceBuilder options = $options');
  final operationLoader = OperationLoader(TypeLoader());
  final restServiceOptions = RestServiceOptions(options);
  return SharedPartBuilder(
      [RestServiceGenerator(operationLoader, restServiceOptions)], 'svc');
}
