import 'package:cloud_firestore/cloud_firestore.dart';

class PswdItemModel {
  final String name;
  final String id;
  final String username;
  final String pswd;
  final String? url;
  final Timestamp creationDate;
  final Timestamp lastUpdated;
  final bool useBiometrics;

  PswdItemModel({
    required this.id,
    required this.name,
    required this.username,
    required this.pswd,
    required this.creationDate,
    required this.lastUpdated,
    required this.url,
    this.useBiometrics = true,
  });

  PswdItemModel copyWith(
          {String? id,
          String? name,
          String? username,
          String? pswd,
          Timestamp? creationDate,
          Timestamp? lastUpdated,
          String? url,
          bool? useBiometrics}) =>
      PswdItemModel(
          name: name ?? this.name,
          id: id ?? this.id,
          username: username ?? this.username,
          pswd: pswd ?? this.pswd,
          creationDate: creationDate ?? this.creationDate,
          lastUpdated: lastUpdated ?? this.lastUpdated,
          url: url ?? this.url,
          useBiometrics: useBiometrics ?? this.useBiometrics);

  factory PswdItemModel.fromJson(Map<String, dynamic> json) => PswdItemModel(
        name: json["name"] ?? '',
        id: json["id"] ?? '',
        username: json["username"] ?? '',
        pswd: json["pswd"] ?? '',
        creationDate: json["creationDate"],
        lastUpdated: json["lastUpdated"] ?? json["creationDate"],
        url: json["url"],
        useBiometrics: json["useBiometrics"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "username": username,
        "pswd": pswd,
        "creationDate": creationDate,
        "lastUpdated": lastUpdated,
        "url": url,
        "useBiometrics": useBiometrics,
      };
}
