import 'package:bench_test_service/bench_test_service.dart';

class LoginResponse extends SuccessResponse {
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

  @override
  String toString() {
    return 'LoginResponse{message: $message, data: $data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginResponse &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          data == other.data;

  @override
  int get hashCode => message.hashCode ^ data.hashCode;
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

  @override
  String toString() {
    return '_Data{user: $user, token: $token}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Data &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          token == other.token;

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
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

  @override
  String toString() {
    return '_User{id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt, isAdmin: $isAdmin, country: $country, education: $education, status: $status, deletedAt: $deletedAt, title: $title, description: $description, img: $img, googleId: $googleId, avatar: $avatar, countryCode: $countryCode, phone: $phone}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          emailVerifiedAt == other.emailVerifiedAt &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          isAdmin == other.isAdmin &&
          country == other.country &&
          education == other.education &&
          status == other.status &&
          deletedAt == other.deletedAt &&
          title == other.title &&
          description == other.description &&
          img == other.img &&
          googleId == other.googleId &&
          avatar == other.avatar &&
          countryCode == other.countryCode &&
          phone == other.phone;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      emailVerifiedAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      isAdmin.hashCode ^
      country.hashCode ^
      education.hashCode ^
      status.hashCode ^
      deletedAt.hashCode ^
      title.hashCode ^
      description.hashCode ^
      img.hashCode ^
      googleId.hashCode ^
      avatar.hashCode ^
      countryCode.hashCode ^
      phone.hashCode;
}
