class LoginResponseModel {
  final String token;
  final String error;
  final String siswa_username;
  final String siswa_password;

  LoginResponseModel({this.token, this.error, this.siswa_username, this.siswa_password});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      siswa_username: json["siswa_username"] != null ? json["siswa_username"] : "",
      siswa_password: json["siswa_password"] != null ? json["siswa_password"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

class LoginRequestModel {
  String siswa_username;
  String siswa_password;

  LoginRequestModel({this.siswa_username, this.siswa_password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': siswa_username.trim(),
      'password': siswa_password.trim(),
    };

    return map;
  }
}
