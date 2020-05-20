import 'package:pip_services_roles/pip_services_roles.dart';

void main(List<String> argument) {
  try {
    var proc = RolesProcess();
    proc.configPath = './config/config.yml';
    proc.run(argument);
  } catch (ex) {
    print(ex);
  }
}
