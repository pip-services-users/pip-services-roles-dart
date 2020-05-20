import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_services_roles/pip_services_roles.dart';

final ROLES = ['Role 1', 'Role 2', 'Role 3'];

class RolesPersistenceFixture {
  IRolesPersistence _persistence;

  RolesPersistenceFixture(IRolesPersistence persistence) {
    expect(persistence, isNotNull);
    _persistence = persistence;
  }

  void testGetAndSetRoles() async {
    // Set party roles
    var role = await _persistence.set(null, UserRolesV1(id: '1', roles: ROLES));

    expect(role, isNotNull);
    expect(role.roles.length, 3);

    // Read and check party roles
    role = await _persistence.getOneById(null, '1');

    expect(role, isNotNull);
    expect(role.roles.length, 3);

    // Get by filter
    var page = await _persistence.getPageByFilter(
        null,
        FilterParams.fromTuples([
          'roles',
          ['Role 1', 'Role X']
        ]),
        PagingParams());

    expect(page, isNotNull);
    expect(page.data.length, 1);
  }
}
