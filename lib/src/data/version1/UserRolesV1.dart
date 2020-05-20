import 'package:pip_services3_commons/pip_services3_commons.dart';

class UserRolesV1 implements IStringIdentifiable {
  @override
  String id;
  List<String> roles;
  DateTime update_time;

  UserRolesV1({String id, List<String> roles, DateTime update_time})
      : id = id,
        roles = roles,
        update_time = update_time;

  void fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roles = List<String>.from(json['roles']);
    var update_time_json = json['update_time'];
    update_time = update_time_json != null
        ? DateTime.tryParse(json['update_time'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'roles': roles,
      'update_time':
          update_time != null ? update_time.toIso8601String() : update_time
    };
  }
}
