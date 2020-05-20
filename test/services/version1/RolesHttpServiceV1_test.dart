import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services_roles/pip_services_roles.dart';

final ROLES = ['Role 1', 'Role 2', 'Role 3'];

var httpConfig = ConfigParams.fromTuples([
  'connection.protocol',
  'http',
  'connection.host',
  'localhost',
  'connection.port',
  3000
]);

void main() {
  group('RolesHttpServiceV1', () {
    RolesMemoryPersistence persistence;
    RolesController controller;
    RolesHttpServiceV1 service;
    http.Client rest;
    String url;

    setUp(() async {
      url = 'http://localhost:3000';
      rest = http.Client();

      persistence = RolesMemoryPersistence();
      persistence.configure(ConfigParams());

      controller = RolesController();
      controller.configure(ConfigParams());

      service = RolesHttpServiceV1();
      service.configure(httpConfig);

      var references = References.fromTuples([
        Descriptor(
            'pip-services-roles', 'persistence', 'memory', 'default', '1.0'),
        persistence,
        Descriptor(
            'pip-services-roles', 'controller', 'default', 'default', '1.0'),
        controller,
        Descriptor('pip-services-roles', 'service', 'http', 'default', '1.0'),
        service
      ]);

      controller.setReferences(references);
      service.setReferences(references);

      await persistence.open(null);
      await service.open(null);
    });

    tearDown(() async {
      await service.close(null);
      await persistence.close(null);
    });

    test('Get and Set Roles', () async {
      // Set party roles
      var resp = await rest.post(url + '/v1/roles/set_roles',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'user_id': '1', 'roles': ROLES}));
      var roles = <String>[];
      roles = List<String>.from(json.decode(resp.body));
      expect(roles, isNotNull);
      expect(roles.length, 3);

      // Read and check party roles
      resp = await rest.post(url + '/v1/roles/get_roles_by_id',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'user_id': '1'}));
      roles = List<String>.from(json.decode(resp.body));
      expect(roles, isNotNull);
      expect(roles.length, 3);
    });

    test('Grant and Revoke Roles', () async {
      // Grant roles first time
      var resp = await rest.post(url + '/v1/roles/grant_roles',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'user_id': '1',
            'roles': ['Role1']
          }));
      var roles = <String>[];
      roles = List<String>.from(json.decode(resp.body));
      expect(roles, isNotNull);
      expect(roles.length, 1);
      expect(roles, ['Role1']);

      // Grant roles second time
      resp = await rest.post(url + '/v1/roles/grant_roles',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'user_id': '1',
            'roles': ['Role1', 'Role2', 'Role3']
          }));
      roles = List<String>.from(json.decode(resp.body));
      expect(roles, isNotNull);
      expect(roles.length, 3);
      expect(roles, ['Role1', 'Role2', 'Role3']);

      // Revoke roles first time
      resp = await rest.post(url + '/v1/roles/revoke_roles',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'user_id': '1',
            'roles': ['Role1']
          }));
      roles = List<String>.from(json.decode(resp.body));
      expect(roles, isNotNull);
      expect(roles.length, 2);
      expect(roles, ['Role2', 'Role3']);

      // Get roles
      resp = await rest.post(url + '/v1/roles/get_roles_by_id',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'user_id': '1'}));
      roles = List<String>.from(json.decode(resp.body));
      expect(roles, isNotNull);
      expect(roles.length, 2);
      expect(roles, ['Role2', 'Role3']);

      // Revoke roles second time
      resp = await rest.post(url + '/v1/roles/revoke_roles',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'user_id': '1',
            'roles': ['Role1', 'Role2']
          }));
      roles = List<String>.from(json.decode(resp.body));
      expect(roles, isNotNull);
      expect(roles.length, 1);
      expect(roles, ['Role3']);
    });

    test('Authorize', () async {
      // Grant roles
      var resp = await rest.post(url + '/v1/roles/grant_roles',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'user_id': '1',
            'roles': ['Role_1', 'Role_2']
          }));
      var roles = <String>[];
      roles = List<String>.from(json.decode(resp.body));
      expect(roles, isNotNull);
      expect(roles.length, 2);

      // Authorize positively
      resp = await rest.post(url + '/v1/roles/authorize',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'user_id': '1',
            'roles': ['Role_1']
          }));
      var result = json.decode(resp.body);
      expect(result, isNotNull);
      expect(result, isTrue);

      // Authorize negatively
      resp = await rest.post(url + '/v1/roles/authorize',
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'user_id': '1',
            'roles': ['Role_2', 'Role_3']
          }));
      result = json.decode(resp.body);
      expect(result, isNotNull);
      expect(result, isFalse);
    });
  });
}
