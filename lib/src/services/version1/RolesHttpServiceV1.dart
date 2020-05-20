import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

class RolesHttpServiceV1 extends CommandableHttpService {
  RolesHttpServiceV1() : super('v1/roles') {
    dependencyResolver.put('controller',
        Descriptor('pip-services-roles', 'controller', '*', '*', '1.0'));
  }
}
