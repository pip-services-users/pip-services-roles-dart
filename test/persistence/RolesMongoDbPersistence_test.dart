import 'dart:io';
import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import 'package:pip_services_roles/pip_services_roles.dart';
import './RolesPersistenceFixture.dart';

void main() {
  group('RolesMongoDbPersistence', () {
    RolesMongoDbPersistence persistence;
    RolesPersistenceFixture fixture;

    setUp(() async {
      var mongoUri = Platform.environment['MONGO_SERVICE_URI'];
      var mongoHost = Platform.environment['MONGO_SERVICE_HOST'] ?? 'localhost';
      var mongoPort = Platform.environment['MONGO_SERVICE_PORT'] ?? '27017';
      var mongoDatabase = Platform.environment['MONGO_SERVICE_DB'] ?? 'test';
      var mongoCollection =
          Platform.environment['MONGO_COLLECTION'] ?? 'user_roles';
      // Exit if mongo connection is not set
      if (mongoUri == '' && mongoHost == '') return;

      var dbConfig = ConfigParams.fromTuples([
        'connection.uri',
        mongoUri,
        'connection.host',
        mongoHost,
        'connection.port',
        mongoPort,
        'connection.database',
        mongoDatabase,
        'collection',
        mongoCollection
      ]);

      persistence = RolesMongoDbPersistence();
      persistence.configure(dbConfig);

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
