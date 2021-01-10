import 'response_status.dart';

class RegisterResponse extends SuccessResponse {
  String message;
  _Data data;

  RegisterResponse(this.message, this.data);

  RegisterResponse.fromJson(dynamic json) {
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
    return 'RegisterResponse{message: $message, data: $data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterResponse &&
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
  String name;
  String email;
  String updatedAt;
  String createdAt;
  int id;

  _User({this.name, this.email, this.updatedAt, this.createdAt, this.id});

  _User.fromJson(dynamic json) {
    name = json["name"];
    email = json["email"];
    updatedAt = json["updated_at"];
    createdAt = json["created_at"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["email"] = email;
    map["updated_at"] = updatedAt;
    map["created_at"] = createdAt;
    map["id"] = id;
    return map;
  }

  @override
  String toString() {
    return '_User{name: $name, email: $email, updatedAt: $updatedAt, createdAt: $createdAt, id: $id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          updatedAt == other.updatedAt &&
          createdAt == other.createdAt &&
          id == other.id;

  @override
  int get hashCode =>
      name.hashCode ^
      email.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode ^
      id.hashCode;
}
