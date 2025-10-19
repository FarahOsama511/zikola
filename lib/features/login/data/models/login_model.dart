class LoginModel {
  final String userName;
  final String? token;
  final String? email;
  final String password;
  LoginModel({
    required this.userName,
     this.token,
     this.email,
    required this.password,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userName: json['userName'],
      token: json['token'],
      email: json['email'],
      password: json['password'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'token': token,
      'email': email,
      'password': password,
    };
  }
}
