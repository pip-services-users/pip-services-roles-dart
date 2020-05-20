import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services_roles/pip_services_roles.dart';

final ROLES = ['Role 1', 'Role 2', 'Role 3'];

void main() {
  group('RolesController', () {
    RolesMemoryPersistence persistence;
    RolesController controller;

    setUp(() async {
      persistence = RolesMemoryPersistence();
      persistence.configure(ConfigParams());

      controller = RolesController();
      controller.configure(ConfigParams());

      var references = References.fromTuples([
        Descriptor(
            'pip-services-roles', 'persistence', 'memory', 'default', '1.0'),
        persistence,
        Descriptor(
            'pip-services-roles', 'controller', 'default', 'default', '1.0'),
        controller
      ]);

      controller.setReferences(references);

      await persistence.open(null);
    });

    tearDown(() async {
      await persistence.close(null);
    });

    test('Get and Set Roles', () async {
      // Set party roles
      var roles = await controller.setRoles(null, '1', ROLES);

      expect(roles, isNotNull);
      expect(roles.length, 3);

      // Read and check party roles
      roles = await controller.getRolesById(null, '1');

      expect(roles, isNotNull);
      expect(roles.length, 3);
    });

    test('Grant and Revoke Roles', () async {
      // Grant roles first time
      var roles = await controller.grantRoles(null, '1', ['Role 1']);

      expect(roles, isNotNull);
      expect(roles.length, 1);
      expect(roles, ['Role 1']);

      // Grant roles second time
      roles = await controller
          .grantRoles(null, '1', ['Role 1', 'Role 2', 'Role 3']);

      expect(roles, isNotNull);
      expect(roles.length, 3);
      expect(roles, ['Role 1', 'Role 2', 'Role 3']);

      // Revoke roles first time
      roles = await controller.revokeRoles(null, '1', ['Role 1']);

      expect(roles, isNotNull);
      expect(roles.length, 2);
      expect(roles, ['Role 2', 'Role 3']);

      // Get roles
      roles = await controller.getRolesById(null, '1');

      expect(roles, isNotNull);
      expect(roles.length, 2);
      expect(roles, ['Role 2', 'Role 3']);

      // Revoke roles second time
      roles = await controller.revokeRoles(null, '1', ['Role 3']);

      expect(roles, isNotNull);
      expect(roles.length, 1);
      expect(roles, ['Role 2']);
    });

    test('Authorize', () async {
      // Grant roles
      var roles = await controller.grantRoles(null, '1', ['Role 1', 'Role 2']);

      expect(roles, isNotNull);
      expect(roles.length, 2);

      // Authorize positively
      var result = await controller.authorize(null, '1', ['Role 1']);

      expect(result, isNotNull);
      expect(result, isTrue);

      // Authorize negatively
      result = await controller.authorize(null, '1', ['Role 2', 'Role 3']);

      expect(result, isNotNull);
      expect(result, isFalse);
    });
  });
}
