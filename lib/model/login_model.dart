class LoginResponseModel {
  final String token;
  final String error;

  LoginResponseModel({this.token, this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
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
