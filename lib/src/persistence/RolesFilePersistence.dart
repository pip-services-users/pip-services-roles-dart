import 'package:pip_services3_data/pip_services3_data.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../data/version1/UserRolesV1.dart';
import './RolesMemoryPersistence.dart';

class RolesFilePersistence extends RolesMemoryPersistence {
  JsonFilePersister<UserRolesV1> persister;

  RolesFilePersistence([String path]) : super() {
    persister = JsonFilePersister<UserRolesV1>(path);
    loader = persister;
    saver = persister;
  }
  @override
  void configure(ConfigParams config) {
    super.configure(config);
    persister.configure(config);
  }
}
