import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../data/version1/UserRolesV1.dart';

abstract class IRolesPersistence {
  Future<DataPage<UserRolesV1>> getPageByFilter(
      String correlationId, FilterParams filter, PagingParams paging);

  Future<UserRolesV1> getOneById(String correlationId, String id);

  Future<UserRolesV1> set(String correlationId, UserRolesV1 item);
}
