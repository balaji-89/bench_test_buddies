/// message : ""
/// data : [{"api_attempt_id":17,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":17,"api_evaluation_id":2,"is_true":1},{"api_attempt_id":7,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":7,"api_evaluation_id":2,"is_true":1},{"api_attempt_id":7,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":7,"api_evaluation_id":2,"is_true":1},{"api_attempt_id":15,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":15,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":15,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":15,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":15,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":15,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":15,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":15,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":15,"api_evaluation_id":2,"is_true":null},{"api_attempt_id":15,"api_evaluation_id":2,"is_true":null}]

class SolutionResponse {
  String _message;
  List<Data> _data;

  String get message => _message;

  List<Data> get data => _data;

  SolutionResponse({String message, List<Data> data}) {
    _message = message;
    _data = data;
  }

  SolutionResponse.fromJson(dynamic json) {
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
    return 'SolutionResponse{_message: $_message, _data: $_data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SolutionResponse &&
          runtimeType == other.runtimeType &&
          _message == other._message &&
          _data == other._data;

  @override
  int get hashCode => _message.hashCode ^ _data.hashCode;
}

class Data {
  int _apiAttemptId;
  int _apiEvaluationId;
  int _isTrue;

  int get apiAttemptId => _apiAttemptId;

  int get apiEvaluationId => _apiEvaluationId;

  dynamic get isTrue => _isTrue;

  Data({int apiAttemptId, int apiEvaluationId, dynamic isTrue}) {
    _apiAttemptId = apiAttemptId;
    _apiEvaluationId = apiEvaluationId;
    _isTrue = isTrue;
  }

  Data.fromJson(dynamic json) {
    _apiAttemptId = json["api_attempt_id"];
    _apiEvaluationId = json["api_evaluation_id"];
    _isTrue = json["is_true"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["api_attempt_id"] = _apiAttemptId;
    map["api_evaluation_id"] = _apiEvaluationId;
    map["is_true"] = _isTrue;
    return map;
  }

  @override
  String toString() {
    return 'Data{_apiAttemptId: $_apiAttemptId, _apiEvaluationId: $_apiEvaluationId, _isTrue: $_isTrue}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Data &&
          runtimeType == other.runtimeType &&
          _apiAttemptId == other._apiAttemptId &&
          _apiEvaluationId == other._apiEvaluationId &&
          _isTrue == other._isTrue;

  @override
  int get hashCode =>
      _apiAttemptId.hashCode ^ _apiEvaluationId.hashCode ^ _isTrue.hashCode;
}
