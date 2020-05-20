import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_services_roles/pip_services_roles.dart';
import './RolesPersistenceFixture.dart';

void main() {
  group('RolesMemoryPersistence', () {
    RolesMemoryPersistence persistence;
    RolesPersistenceFixture fixture;

    setUp(() async {
      persistence = RolesMemoryPersistence();
      persistence.configure(ConfigParams());

      fixture = RolesPersistenceFixture(persistence);

      await persistence.open(null);
    });

    tearDown(() async {
      await persistence.close(null);
    });

    test('Get and Set Roles', () async {
      await fixture.testGetAndSetRoles();
    });
  });
}
