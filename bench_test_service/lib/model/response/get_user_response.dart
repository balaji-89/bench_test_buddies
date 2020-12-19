class GetUserResponse {
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
}
