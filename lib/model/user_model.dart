class UserModel {
  String? userId;
  String? name;
  String? profession;

  UserModel({
    this.userId,
    this.name,
    this.profession,
  });

  factory UserModel.fromJson(json) {
    return UserModel(
      userId: json["userId"] ?? '',
      name: json["name"] ?? '',
      profession: json["profession"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "profession": profession,
      };
}
