import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_services_roles/pip_services_roles.dart';
import './RolesPersistenceFixture.dart';

void main() {
  group('RolesFilePersistence', () {
    RolesFilePersistence persistence;
    RolesPersistenceFixture fixture;

    setUp(() async {
      persistence = RolesFilePersistence('data/roles.test.json');
      persistence.configure(ConfigParams());

      fixture = RolesPersistenceFixture(persistence);

      await persistence.open(null);
      await persistence.clear(null);
    });

    tearDown(() async {
      await persistence.close(null);
    });

    test('Get and Set Roles', () async {
      await fixture.testGetAndSetRoles();
    });
  });
}
