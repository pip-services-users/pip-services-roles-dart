import 'package:pip_services3_container/pip_services3_container.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';

import '../build/RolesServiceFactory.dart';

class RolesProcess extends ProcessContainer {
  RolesProcess() : super('roles', 'User roles microservice') {
    factories.add(RolesServiceFactory());
    factories.add(DefaultRpcFactory());
  }
}
