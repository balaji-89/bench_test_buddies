class LoginResponse {
  String message;
  _Data data;

  LoginResponse(this.message, this.data);

  LoginResponse.fromJson(dynamic json) {
    message = json["message"];
    data = json["data"] != null ? _Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = message;
    if (data != null) {
      map["data"] = data.toJson();
    }
    return map;
  }
}

class _Data {
  _User user;
  String token;

  _Data({this.user, this.token});

  _Data.fromJson(dynamic json) {
    user = json["user"] != null ? _User.fromJson(json["user"]) : null;
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (user != null) {
      map["user"] = user.toJson();
    }
    map["token"] = token;
    return map;
  }
}

class _User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String createdAt;
  String updatedAt;
  dynamic isAdmin;
  dynamic country;
  dynamic education;
  int status;
  dynamic deletedAt;
  String title;
  String description;
  String img;
  dynamic googleId;
  String avatar;
  dynamic countryCode;
  dynamic phone;

  _User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.isAdmin,
      this.country,
      this.education,
      this.status,
      this.deletedAt,
      this.title,
      this.description,
      this.img,
      this.googleId,
      this.avatar,
      this.countryCode,
      this.phone});

  _User.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    emailVerifiedAt = json["email_verified_at"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    isAdmin = json["is_admin"];
    country = json["country"];
    education = json["education"];
    status = json["status"];
    deletedAt = json["deleted_at"];
    title = json["title"];
    description = json["description"];
    img = json["img"];
    googleId = json["google_id"];
    avatar = json["avatar"];
    countryCode = json["country_code"];
    phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["email"] = email;
    map["email_verified_at"] = emailVerifiedAt;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["is_admin"] = isAdmin;
    map["country"] = country;
    map["education"] = education;
    map["status"] = status;
    map["deleted_at"] = deletedAt;
    map["title"] = title;
    map["description"] = description;
    map["img"] = img;
    map["google_id"] = googleId;
    map["avatar"] = avatar;
    map["country_code"] = countryCode;
    map["phone"] = phone;
    return map;
  }
}
