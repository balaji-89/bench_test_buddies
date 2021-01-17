class AttemptsResponse {
  String _message;
  List<Data> _data;

  String get message => _message;

  List<Data> get data => _data;

  AttemptsResponse({String message, List<Data> data}) {
    _message = message;
    _data = data;
  }

  AttemptsResponse.fromJson(dynamic json) {
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'AttemptsResponse{_message: $_message, _data: $_data}';
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttemptsResponse &&
          runtimeType == other.runtimeType &&
          _message == other._message &&
          _data == other._data;

  @override
  int get hashCode => _message.hashCode ^ _data.hashCode;
}

class Data {
  int _id;
  int _apiExerciseId;

  int get id => _id;

  int get apiExerciseId => _apiExerciseId;

  Data({int id, int apiExerciseId}) {
    _id = id;
    _apiExerciseId = apiExerciseId;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _apiExerciseId = json["api_exercise_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["api_exercise_id"] = _apiExerciseId;
    return map;
  }

  @override
  String toString() {
    return 'Data{_id: $_id, _apiExerciseId: $_apiExerciseId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Data &&
          runtimeType == other.runtimeType &&
          _id == other._id &&
          _apiExerciseId == other._apiExerciseId;

  @override
  int get hashCode => _id.hashCode ^ _apiExerciseId.hashCode;
}
