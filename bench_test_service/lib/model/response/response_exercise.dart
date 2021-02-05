class ResponseExercise {
  String _message;
  List<ExerciseData> _data;

  String get message => _message;

  List<ExerciseData> get exercises => _data;

  ResponseExercise({String message, List<ExerciseData> data}) {
    _message = message;
    _data = data;
  }

  ResponseExercise.fromJson(dynamic json) {
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(ExerciseData.fromJson(v));
      });
    }
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
  String toString() {
    return 'ResponseExercise{_message: $_message, _data: $_data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseExercise &&
          runtimeType == other.runtimeType &&
          _message == other._message &&
          _data == other._data;

  @override
  int get hashCode => _message.hashCode ^ _data.hashCode;
}

class ExerciseData {
  int _id;
  String _name;
  String _description;

  int get id => _id;
  String get description => _description;
  String get name => _name;

  ExerciseData({int id, String name,String description}) {
    _id = id;
    _name = name;
    _description=description;
  }

  ExerciseData.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _description=json["description"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["description"]=_description;
    return map;
  }

  @override
  String toString() {
    return 'ExerciseData{_id: $_id, _name: $_name,_description:$description}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseData &&
          runtimeType == other.runtimeType &&
          _id == other._id &&
          _name == other._name &&
         _description == other._description;

  @override
  int get hashCode => _id.hashCode ^ _name.hashCode^ _description.hashCode;
}
