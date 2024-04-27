import 'package:swarden/app/domain/enums/roles.dart';

class UserModel {
  final String id;
  final String username;
  final Roles role;
  final String countryCode;

  UserModel({
    required this.id,
    required this.username,
    required this.role,
    required this.countryCode,
  });

  UserModel copyWith({
    String? id,
    String? username,
    Roles? role,
    String? countryCode,
  }) =>
      UserModel(
        id: id ?? this.id,
        username: username ?? this.username,
        role: role ?? this.role,
        countryCode: countryCode ?? this.countryCode,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? '',
        username: json["username"] ?? '',
        role: stringToRole(json["role"]) ?? Roles.user,
        countryCode: json["countryCode"] ?? 'ES',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "role": role,
        "countryCode": countryCode,
      };

  static Roles? stringToRole(String? role) {
    if (role == null) {
      return null;
    }
    switch (role) {
      case 'user':
        return Roles.user;
      case 'prouser':
        return Roles.proUser;
      case 'maintenance':
        return Roles.maintenance;
      case 'admin':
        return Roles.admin;
      default:
        return Roles.user;
    }
  }
}
