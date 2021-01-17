class ExerciseEvaluationResponse {
  String _message;
  List<Data> _data;

  String get message => _message;

  List<Data> get data => _data;

  ExerciseEvaluationResponse({String message, List<Data> data}) {
    _message = message;
    _data = data;
  }

  ExerciseEvaluationResponse.fromJson(dynamic json) {
    _message = json["message"];
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
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
    return 'ExerciseEvaluationResponse{_message: $_message, _data: $_data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseEvaluationResponse &&
          runtimeType == other.runtimeType &&
          _message == other._message &&
          _data == other._data;

  @override
  int get hashCode => _message.hashCode ^ _data.hashCode;
}

class Data {
  int _id;
  int _apiExerciseId;
  String _image;
  dynamic _video;
  String _title;
  String _question;
  int _answerType;
  int _points;
  int _answerBoolean;
  dynamic _answerDouble;
  String _explanation;
  String _commonErrorCause;
  String _prevent;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _deletedAt;

  int get id => _id;

  int get apiExerciseId => _apiExerciseId;

  String get image => _image;

  dynamic get video => _video;

  String get title => _title;

  String get question => _question;

  int get answerType => _answerType;

  int get points => _points;

  int get answerBoolean => _answerBoolean;

  dynamic get answerDouble => _answerDouble;

  String get explanation => _explanation;

  String get commonErrorCause => _commonErrorCause;

  String get prevent => _prevent;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  dynamic get deletedAt => _deletedAt;

  Data(
      {int id,
      int apiExerciseId,
      String image,
      dynamic video,
      String title,
      String question,
      int answerType,
      int points,
      int answerBoolean,
      dynamic answerDouble,
      String explanation,
      String commonErrorCause,
      String prevent,
      dynamic createdAt,
      dynamic updatedAt,
      dynamic deletedAt}) {
    _id = id;
    _apiExerciseId = apiExerciseId;
    _image = image;
    _video = video;
    _title = title;
    _question = question;
    _answerType = answerType;
    _points = points;
    _answerBoolean = answerBoolean;
    _answerDouble = answerDouble;
    _explanation = explanation;
    _commonErrorCause = commonErrorCause;
    _prevent = prevent;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _apiExerciseId = json["api_exercise_id"];
    _image = json["image"];
    _video = json["video"];
    _title = json["title"];
    _question = json["question"];
    _answerType = json["answer_type"];
    _points = json["points"];
    _answerBoolean = json["answer_boolean"];
    _answerDouble = json["answer_double"];
    _explanation = json["explanation"];
    _commonErrorCause = json["common_error_cause"];
    _prevent = json["prevent"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["api_exercise_id"] = _apiExerciseId;
    map["image"] = _image;
    map["video"] = _video;
    map["title"] = _title;
    map["question"] = _question;
    map["answer_type"] = _answerType;
    map["points"] = _points;
    map["answer_boolean"] = _answerBoolean;
    map["answer_double"] = _answerDouble;
    map["explanation"] = _explanation;
    map["common_error_cause"] = _commonErrorCause;
    map["prevent"] = _prevent;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map["deleted_at"] = _deletedAt;
    return map;
  }

  @override
  String toString() {
    return 'Data{_id: $_id, _apiExerciseId: $_apiExerciseId, _image: $_image, _video: $_video, _title: $_title, _question: $_question, _answerType: $_answerType, _points: $_points, _answerBoolean: $_answerBoolean, _answerDouble: $_answerDouble, _explanation: $_explanation, _commonErrorCause: $_commonErrorCause, _prevent: $_prevent, _createdAt: $_createdAt, _updatedAt: $_updatedAt, _deletedAt: $_deletedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Data &&
          runtimeType == other.runtimeType &&
          _id == other._id &&
          _apiExerciseId == other._apiExerciseId &&
          _image == other._image &&
          _video == other._video &&
          _title == other._title &&
          _question == other._question &&
          _answerType == other._answerType &&
          _points == other._points &&
          _answerBoolean == other._answerBoolean &&
          _answerDouble == other._answerDouble &&
          _explanation == other._explanation &&
          _commonErrorCause == other._commonErrorCause &&
          _prevent == other._prevent &&
          _createdAt == other._createdAt &&
          _updatedAt == other._updatedAt &&
          _deletedAt == other._deletedAt;

  @override
  int get hashCode =>
      _id.hashCode ^
      _apiExerciseId.hashCode ^
      _image.hashCode ^
      _video.hashCode ^
      _title.hashCode ^
      _question.hashCode ^
      _answerType.hashCode ^
      _points.hashCode ^
      _answerBoolean.hashCode ^
      _answerDouble.hashCode ^
      _explanation.hashCode ^
      _commonErrorCause.hashCode ^
      _prevent.hashCode ^
      _createdAt.hashCode ^
      _updatedAt.hashCode ^
      _deletedAt.hashCode;
}
