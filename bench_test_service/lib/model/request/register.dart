class RegisterRequest {
  String name;
  String email;
  String password;
  String passwordConfirmation;

  RegisterRequest(
      this.name, 
      this.email, 
      this.password, 
      this.passwordConfirmation);

  RegisterRequest.fromJson(dynamic json) {
    name = json["name"];
    email = json["email"];
    password = json["password"];
    passwordConfirmation = json["password_confirmation"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["password"] = password;
    map["password_confirmation"] = passwordConfirmation;
    return map;
  }

}
