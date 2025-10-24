class UserModel {
  final int? id;
  final String? name;
  final String? userName;
  final String? email;
  final int? ordersLimit;
  final String? role;

  UserModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.ordersLimit,
    required this.role,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      userName: json["userName"],
      email: json["email"],
      ordersLimit: json["ordersLimit"],
      role: json["role"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "userName": userName,
      "email": email,
      "orderLimit": ordersLimit,
      "role": role,
    };
  }
}
