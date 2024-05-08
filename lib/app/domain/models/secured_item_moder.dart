class SecuredItemModel {
  final String name;
  final String email;
  final String pswd;
  final int encrType;

  SecuredItemModel({
    required this.name,
    required this.email,
    required this.pswd,
    required this.encrType,
  });

  SecuredItemModel copyWith({
    String? name,
    String? email,
    String? pswd,
    int? encrType,
  }) =>
      SecuredItemModel(
        name: name ?? this.name,
        email: email ?? this.email,
        pswd: pswd ?? this.pswd,
        encrType: encrType ?? this.encrType,
      );

  factory SecuredItemModel.fromJson(Map<String, dynamic> json) =>
      SecuredItemModel(
        name: json["name"],
        email: json["email"],
        pswd: json["pswd"],
        encrType: json["encrType"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "pswd": pswd,
        "encrType": encrType,
      };
}
