import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import '../../src/data/version1/UserRolesV1.dart';

abstract class IRolesController {
  /// Gets a page of roles retrieved by a given filter.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [filter]            (optional) a filter function to filter items
  /// - [paging]            (optional) paging parameters
  /// Return         Future that receives a data page
  /// Throws error.
  Future<DataPage<UserRolesV1>> getRolesByFilter(
      String correlationId, FilterParams filter, PagingParams paging);

  /// Gets an user roles by user unique id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// Return         Future that receives user roles or error.
  Future<List<String>> getRolesById(String correlationId, String userId);

  /// Sets a roles.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be set.
  /// Return         (optional) Future that receives set roles or error.
  Future<List<String>> setRoles(
      String correlationId, String userId, List<String> roles);

  /// Grants a roles.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be granted.
  /// Return         (optional) Future that receives granted roles or error.
  Future<List<String>> grantRoles(
      String correlationId, String userId, List<String> roles);

  /// Revokes a roles.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be revoked.
  /// Return         (optional) Future that receives revoked roles or error.
  Future<List<String>> revokeRoles(
      String correlationId, String userId, List<String> roles);

  /// Checks the authorization.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be revoked.
  /// Return         (optional) Future that receives bool value of authorization or error.
  Future<bool> authorize(
      String correlationId, String userId, List<String> roles);
}
