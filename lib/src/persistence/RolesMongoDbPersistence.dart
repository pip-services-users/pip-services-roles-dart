import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_mongodb/pip_services3_mongodb.dart';

import '../data/version1/UserRolesV1.dart';
import './IRolesPersistence.dart';

class RolesMongoDbPersistence
    extends IdentifiableMongoDbPersistence<UserRolesV1, String>
    implements IRolesPersistence {
  RolesMongoDbPersistence() : super('user_roles') {
    maxPageSize = 1000;
  }

  dynamic composeFilter(FilterParams filter) {
    filter = filter ?? FilterParams();

    var criteria = [];

    var id = filter.getAsNullableString('id');
    if (id != null) {
      criteria.add({'_id': id});
    }

    // Filter ids
    var ids = filter.getAsObject('ids');
    if (ids is String) {
      ids = (ids as String).split(',');
    }
    if (ids is List) {
      criteria.add({
        '_id': {r'$in': ids}
      });
    }

    // Filter except ids
    var exceptIds = filter.getAsObject('except_ids');
    if (exceptIds is String) {
      exceptIds = (ids as String).split(',');
    }
    if (exceptIds is List) {
      criteria.add({
        '_id': {r'$nin': exceptIds}
      });
    }

    // Filter roles
    var roles = filter.getAsObject('roles');
    if (roles is String) {
      roles = (roles as String).split(',');
    }
    if (roles is List) {
      criteria.add({
        'roles': {r'$in': roles}
      });
    }

    // Filter except roles
    var exceptRoles = filter.getAsObject('except_roles');
    if (exceptRoles is String) {
      exceptRoles = (exceptRoles as String).split(',');
    }
    if (exceptRoles is List) {
      criteria.add({
        'roles': {r'$nin': exceptRoles}
      });
    }

    return criteria.isNotEmpty ? {r'$and': criteria} : null;
  }

  @override
  Future<DataPage<UserRolesV1>> getPageByFilter(
      String correlationId, FilterParams filter, PagingParams paging) async {
    return super
        .getPageByFilterEx(correlationId, composeFilter(filter), paging, null);
  }

  @override
  Future<UserRolesV1> set(String correlationId, UserRolesV1 item) async {
    if (item == null) {
      return null;
    }

    item.update_time = item.update_time ?? DateTime.now();

    return super.set(correlationId, item);
  }
}
