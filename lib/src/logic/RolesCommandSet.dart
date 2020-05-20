import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../../src/logic/IRolesController.dart';

class RolesCommandSet extends CommandSet {
  IRolesController _controller;

  RolesCommandSet(IRolesController controller) : super() {
    _controller = controller;

    addCommand(_makeGetRolesByFilterCommand());
    addCommand(_makeGetRoleByIdCommand());
    addCommand(_makeSetRolesCommand());
    addCommand(_makeGrantRolesCommand());
    addCommand(_makeRevokeRolesCommand());
    addCommand(_makeAuthorizeCommand());
  }

  ICommand _makeGetRolesByFilterCommand() {
    return Command(
        'get_roles_by_filter',
        ObjectSchema(true)
            .withOptionalProperty('filter', FilterParamsSchema())
            .withOptionalProperty('paging', PagingParamsSchema()),
        (String correlationId, Parameters args) {
      var filter = FilterParams.fromValue(args.get('filter'));
      var paging = PagingParams.fromValue(args.get('paging'));
      return _controller.getRolesByFilter(correlationId, filter, paging);
    });
  }

  ICommand _makeGetRoleByIdCommand() {
    return Command('get_roles_by_id',
        ObjectSchema(true).withRequiredProperty('user_id', TypeCode.String),
        (String correlationId, Parameters args) {
      var userId = args.getAsNullableString('user_id');
      return _controller.getRolesById(correlationId, userId);
    });
  }

  ICommand _makeSetRolesCommand() {
    return Command(
        'set_roles',
        ObjectSchema(true)
            .withRequiredProperty('user_id', TypeCode.String)
            .withRequiredProperty('roles', ArraySchema(TypeCode.String)),
        (String correlationId, Parameters args) {
      var userId = args.getAsNullableString('user_id');
      var roles = List<String>.from(args.get('roles'));
      return _controller.setRoles(correlationId, userId, roles);
    });
  }

  ICommand _makeGrantRolesCommand() {
    return Command(
        'grant_roles',
        ObjectSchema(true)
            .withRequiredProperty('user_id', TypeCode.String)
            .withRequiredProperty('roles', ArraySchema(TypeCode.String)),
        (String correlationId, Parameters args) {
      var userId = args.getAsNullableString('user_id');
      var roles = List<String>.from(args.get('roles'));
      return _controller.grantRoles(correlationId, userId, roles);
    });
  }

  ICommand _makeRevokeRolesCommand() {
    return Command(
        'revoke_roles',
        ObjectSchema(true)
            .withRequiredProperty('user_id', TypeCode.String)
            .withRequiredProperty('roles', ArraySchema(TypeCode.String)),
        (String correlationId, Parameters args) {
      var userId = args.getAsNullableString('user_id');
      var roles = List<String>.from(args.get('roles'));
      return _controller.revokeRoles(correlationId, userId, roles);
    });
  }

  ICommand _makeAuthorizeCommand() {
    return Command(
        'authorize',
        ObjectSchema(true)
            .withRequiredProperty('user_id', TypeCode.String)
            .withRequiredProperty('roles', ArraySchema(TypeCode.String)),
        (String correlationId, Parameters args) {
      var userId = args.getAsNullableString('user_id');
      var roles = List<String>.from(args.get('roles'));
      return _controller.authorize(correlationId, userId, roles);
    });
  }
}
