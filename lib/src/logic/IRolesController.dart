import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../../src/data/version1/UserRolesV1.dart';

abstract class IRolesController {
  Future<DataPage<UserRolesV1>> getRolesByFilter(
      String correlationId, FilterParams filter, PagingParams paging);

  Future<List<String>> getRolesById(String correlationId, String userId);

  Future<List<String>> setRoles(
      String correlationId, String userId, List<String> roles);

  Future<List<String>> grantRoles(
      String correlationId, String userId, List<String> roles);

  Future<List<String>> revokeRoles(
      String correlationId, String userId, List<String> roles);

  Future<bool> authorize(
      String correlationId, String userId, List<String> roles);
}
