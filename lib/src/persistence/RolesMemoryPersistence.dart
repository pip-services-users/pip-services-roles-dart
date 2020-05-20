import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_data/pip_services3_data.dart';
import '../data/version1/UserRolesV1.dart';
import './IRolesPersistence.dart';

class RolesMemoryPersistence
    extends IdentifiableMemoryPersistence<UserRolesV1, String>
    implements IRolesPersistence {
  RolesMemoryPersistence() : super() {
    maxPageSize = 1000;
  }

  bool contains(List<String> array1, List<String> array2) {
    if (array1 == null || array2 == null) return false;

    for (var i1 = 0; i1 < array1.length; i1++) {
      for (var i2 = 0; i2 < array2.length; i2++) {
        if (array1[i1] == array2[i2]) {
          return true;
        }
      }
    }

    return false;
  }

  Function composeFilter(FilterParams filter) {
    filter = filter ?? FilterParams();

    var id = filter.getAsNullableString('id');
    var ids = filter.getAsObject('ids');
    var exceptIds = filter.getAsObject('except_ids');
    var roles = filter.getAsObject('roles');
    var exceptRoles = filter.getAsObject('except_roles');

    // Process ids filter
    if (ids != null && ids is String) {
      ids = (ids as String).split(',');
    }
    if (ids != null && !(ids is List)) {
      ids = null;
    }

    // Process except ids filter
    if (exceptIds != null && exceptIds is String) {
      exceptIds = (exceptIds as String).split(',');
    }
    if (exceptIds != null && !(exceptIds is List)) {
      exceptIds = null;
    }

    // Process roles filter
    if (roles != null && roles is String) {
      roles = (roles as String).split(',');
    }
    if (roles != null && !(roles is List)) {
      roles = null;
    }

    // Process except roles filter
    if (exceptRoles != null && exceptRoles is String) {
      exceptRoles = (exceptRoles as String).split(',');
    }
    if (exceptRoles != null && !(exceptRoles is List)) {
      exceptRoles = null;
    }

    return (item) {
      if (id != null && item.id != id) {
        return false;
      }
      if (ids != null && !(ids as List).contains(item.id)) {
        return false;
      }
      if (exceptIds != null && (exceptIds as List).contains(item.id)) {
        return false;
      }
      if (roles != null && !contains((roles as List), item.roles)) {
        return false;
      }
      if (exceptRoles != null && contains((exceptRoles as List), item.roles)) {
        return false;
      }
      return true;
    };
  }

  @override
  Future<DataPage<UserRolesV1>> getPageByFilter(
      String correlationId, FilterParams filter, PagingParams paging) {
    return super
        .getPageByFilterEx(correlationId, composeFilter(filter), paging, null);
  }

  @override
  Future<UserRolesV1> set(String correlationId, UserRolesV1 item) async {
    if (item == null) {
      return null;
    }

    item.update_time = DateTime.now();

    return super.set(correlationId, item);
  }
}
