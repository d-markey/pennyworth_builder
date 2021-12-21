import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'descriptors/operation_loader.dart';
import 'descriptors/type_loader.dart';
import 'rest_entity_generator.dart';
import 'rest_service_generator.dart';

Builder restEntityBuilder(BuilderOptions options) {
  final typeLoader = TypeLoader();
  return SharedPartBuilder([RestEntityGenerator(typeLoader)], 'dto');
}

Builder restServiceBuilder(BuilderOptions options) {
  final operationLoader = OperationLoader(TypeLoader());
  return SharedPartBuilder([RestServiceGenerator(operationLoader)], 'svc');
}
