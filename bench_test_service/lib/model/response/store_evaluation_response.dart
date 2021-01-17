class StoreEvaluationResponse {
  String _message;
  Data _data;

  String get message => _message;

  Data get data => _data;

  StoreEvaluationResponse({String message, Data data}) {
    _message = message;
    _data = data;
  }

  StoreEvaluationResponse.fromJson(dynamic json) {
    _message = json["message"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = _message;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }

  @override
  String toString() {
    return 'StoreEvaluationResponse{_message: $_message, _data: $_data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreEvaluationResponse &&
          runtimeType == other.runtimeType &&
          _message == other._message &&
          _data == other._data;

  @override
  int get hashCode => _message.hashCode ^ _data.hashCode;
}

class Data {
  String _actualScore;
  String _maxScore;
  String _expectedScore;
  String _buddyWord;

  String get actualScore => _actualScore;

  String get maxScore => _maxScore;

  String get expectedScore => _expectedScore;

  String get buddyWord => _buddyWord;

  Data(
      {String actualScore,
      String maxScore,
      String expectedScore,
      String buddyWord}) {
    _actualScore = actualScore;
    _maxScore = maxScore;
    _expectedScore = expectedScore;
    _buddyWord = buddyWord;
  }

  Data.fromJson(dynamic json) {
    _actualScore = json["actual_score"];
    _maxScore = json["max_score"];
    _expectedScore = json["expected_score"];
    _buddyWord = json["buddy_word"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["actual_score"] = _actualScore;
    map["max_score"] = _maxScore;
    map["expected_score"] = _expectedScore;
    map["buddy_word"] = _buddyWord;
    return map;
  }

  @override
  String toString() {
    return 'Data{_actualScore: $_actualScore, _maxScore: $_maxScore, _expectedScore: $_expectedScore, _buddyWord: $_buddyWord}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Data &&
          runtimeType == other.runtimeType &&
          _actualScore == other._actualScore &&
          _maxScore == other._maxScore &&
          _expectedScore == other._expectedScore &&
          _buddyWord == other._buddyWord;

  @override
  int get hashCode =>
      _actualScore.hashCode ^
      _maxScore.hashCode ^
      _expectedScore.hashCode ^
      _buddyWord.hashCode;
}
