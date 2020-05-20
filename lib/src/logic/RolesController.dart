import 'dart:async';

import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../../src/data/version1/UserRolesV1.dart';
import '../../src/persistence/IRolesPersistence.dart';
import './IRolesController.dart';
import './RolesCommandSet.dart';

class RolesController
    implements IRolesController, IConfigurable, IReferenceable, ICommandable {
  static final ConfigParams _defaultConfig = ConfigParams.fromTuples(
      ['dependencies.persistence', 'pip-services-roles:persistence:*:*:1.0']);
  IRolesPersistence persistence;
  RolesCommandSet commandSet;
  DependencyResolver dependencyResolver =
      DependencyResolver(RolesController._defaultConfig);

  /// Configures component by passing configuration parameters.
  ///
  /// - [config]    configuration parameters to be set.
  @override
  void configure(ConfigParams config) {
    dependencyResolver.configure(config);
  }

  /// Set references to component.
  ///
  /// - [references]    references parameters to be set.
  @override
  void setReferences(IReferences references) {
    dependencyResolver.setReferences(references);
    persistence =
        dependencyResolver.getOneRequired<IRolesPersistence>('persistence');
  }

  /// Gets a command set.
  ///
  /// Return Command set
  @override
  CommandSet getCommandSet() {
    commandSet ??= RolesCommandSet(this);
    return commandSet;
  }

  /// Gets a page of roles retrieved by a given filter.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [filter]            (optional) a filter function to filter items
  /// - [paging]            (optional) paging parameters
  /// Return         Future that receives a data page
  /// Throws error.
  @override
  Future<DataPage<UserRolesV1>> getRolesByFilter(
      String correlationId, FilterParams filter, PagingParams paging) {
    return persistence.getPageByFilter(correlationId, filter, paging);
  }

  /// Gets an user roles by user unique id.
  ///
  /// - [correlationId]     (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// Return         Future that receives user roles or error.
  @override
  Future<List<String>> getRolesById(String correlationId, String userId) async {
    var role = await persistence.getOneById(correlationId, userId);
    return role != null ? role.roles : [];
  }

  /// Sets a roles.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be set.
  /// Return         (optional) Future that receives set roles or error.
  @override
  Future<List<String>> setRoles(
      String correlationId, String userId, List<String> roles) async {
    var item = UserRolesV1(id: userId, roles: roles);
    var role = await persistence.set(correlationId, item);
    return role != null ? role.roles : [];
  }

  /// Grants a roles.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be granted.
  /// Return         (optional) Future that receives granted roles or error.
  @override
  Future<List<String>> grantRoles(
      String correlationId, String userId, List<String> roles) async {
    if (roles.isEmpty) {
      return [];
    }
    var existingRoles = await getRolesById(correlationId, userId);
    var newRoles = roles;

    newRoles.addAll(existingRoles);

    return setRoles(correlationId, userId, newRoles.toSet().toList());
  }

  List<String> _difference(List<String> existingRoles, List<String> newRoles) {
    if (existingRoles == null && newRoles == null) return [];

    return existingRoles.toSet().difference(newRoles.toSet()).toList();
  }

  /// Revokes a roles.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be revoked.
  /// Return         (optional) Future that receives revoked roles or error.
  @override
  Future<List<String>> revokeRoles(
      String correlationId, String userId, List<String> roles) async {
    if (roles.isEmpty) {
      return [];
    }
    var existingRoles = await getRolesById(correlationId, userId);

    var newRoles = _difference(existingRoles, roles);

    return setRoles(correlationId, userId, newRoles);
  }

  /// Checks the authorization.
  ///
  /// - [correlation_id]    (optional) transaction id to trace execution through call chain.
  /// - [userId]                an user id.
  /// - [roles]                a roles to be revoked.
  /// Return         (optional) Future that receives bool value of authorization or error.
  @override
  Future<bool> authorize(
      String correlationId, String userId, List<String> roles) async {
    if (roles.isEmpty) {
      return null;
    }
    var existingRoles = await getRolesById(correlationId, userId);

    var authorized = _difference(roles, existingRoles).isEmpty;

    return authorized;
  }
}
