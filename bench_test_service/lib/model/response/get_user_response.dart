import 'package:bench_test_service/bench_test_service.dart';

class GetUserResponse extends SuccessResponse{
  String _name;
  String _email;
  DateTime _createdAt;

  String get name => _name;

  String get email => _email;

  DateTime get createdAt => _createdAt;

  GetUserResponse({String name, String email, String createdAt}) {
    _name = name;
    _email = email;
    _createdAt = DateTime.parse(createdAt);
  }

  GetUserResponse.fromJson(dynamic json) {
    _name = json["name"];
    _email = json["email"];
    _createdAt = DateTime.parse(json["created_at"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["email"] = _email;
    map["created_at"] = _createdAt;
    return map;
  }

  @override
  String toString() {
    return 'GetUserResponse{_name: $_name, _email: $_email, _createdAt: $_createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetUserResponse &&
          runtimeType == other.runtimeType &&
          _name == other._name &&
          _email == other._email &&
          _createdAt == other._createdAt;

  @override
  int get hashCode => _name.hashCode ^ _email.hashCode ^ _createdAt.hashCode;
}
