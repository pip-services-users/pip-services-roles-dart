import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../persistence/RolesMemoryPersistence.dart';
import '../persistence/RolesFilePersistence.dart';
import '../persistence/RolesMongoDbPersistence.dart';
import '../logic/RolesController.dart';
import '../services/version1/RolesHttpServiceV1.dart';

class RolesServiceFactory extends Factory {
  static final MemoryPersistenceDescriptor =
      Descriptor('pip-services-roles', 'persistence', 'memory', '*', '1.0');
  static final FilePersistenceDescriptor =
      Descriptor('pip-services-roles', 'persistence', 'file', '*', '1.0');
  static final MongoDbPersistenceDescriptor =
      Descriptor('pip-services-roles', 'persistence', 'mongodb', '*', '1.0');
  static final ControllerDescriptor =
      Descriptor('pip-services-roles', 'controller', 'default', '*', '1.0');
  static final HttpServiceDescriptor =
      Descriptor('pip-services-roles', 'service', 'http', '*', '1.0');

  RolesServiceFactory() : super() {
    registerAsType(RolesServiceFactory.MemoryPersistenceDescriptor,
        RolesMemoryPersistence);
    registerAsType(
        RolesServiceFactory.FilePersistenceDescriptor, RolesFilePersistence);
    registerAsType(RolesServiceFactory.MongoDbPersistenceDescriptor,
        RolesMongoDbPersistence);
    registerAsType(RolesServiceFactory.ControllerDescriptor, RolesController);
    registerAsType(
        RolesServiceFactory.HttpServiceDescriptor, RolesHttpServiceV1);
  }
}
