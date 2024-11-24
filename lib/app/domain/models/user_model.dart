import 'package:swarden/app/core/enums/roles.dart';

class UserModel {
  final String id;
  final String name;
  final String lastName;
  final String username;
  final String email;
  final Roles role;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    required this.name,
    required this.lastName,
  });

  UserModel copyWith({
    String? id,
    String? username,
    Roles? role,
    String? email,
    String? name,
    String? lastName,
  }) =>
      UserModel(
        id: id ?? this.id,
        username: username ?? this.username,
        role: role ?? this.role,
        email: email ?? this.email,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? '',
        username: json["username"] ?? '',
        role: stringToRole(json["role"]) ?? Roles.user,
        email: json["email"] ?? '',
        name: json["name"] ?? '',
        lastName: json["lastName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "role": role.name,
        "email": email,
        "name": name,
        "lastName": lastName
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
