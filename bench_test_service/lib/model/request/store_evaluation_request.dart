class StoreEvaluationRequest {
  List<EvaluationData> _evaluationData;
  int _attemptId;
  int _evaluationId;

  List<EvaluationData> get evaluationData => _evaluationData;

  int get attemptId => _attemptId;

  int get evaluationId => _evaluationId;

  StoreEvaluationRequest(
      List<EvaluationData> evaluationData, int attemptId, int evaluationId) {
    _evaluationData = evaluationData;
    _attemptId = attemptId;
    _evaluationId = evaluationId;
  }

  StoreEvaluationRequest.fromJson(dynamic json) {
    if (json["evaluation_data"] != null) {
      _evaluationData = [];
      json["evaluation_data"].forEach((v) {
        _evaluationData.add(EvaluationData.fromJson(v));
      });
    }
    _attemptId = json["attempt_id"];
    _evaluationId = json["evaluation_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_evaluationData != null) {
      map["evaluation_data"] = _evaluationData.map((v) => v.toJson()).toList();
    }
    map["attempt_id"] = _attemptId;
    map["evaluation_id"] = _evaluationId;
    return map;
  }

  @override
  String toString() {
    return 'StoreEvaluationRequest{_evaluationData: $_evaluationData, _attemptId: $_attemptId, _evaluationId: $_evaluationId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreEvaluationRequest &&
          runtimeType == other.runtimeType &&
          _evaluationData == other._evaluationData &&
          _attemptId == other._attemptId &&
          _evaluationId == other._evaluationId;

  @override
  int get hashCode =>
      _evaluationData.hashCode ^ _attemptId.hashCode ^ _evaluationId.hashCode;
}

class EvaluationData {
  int _questionId;
  double _answer;
  int _answerType;

  int get questionId => _questionId;

  double get answer => _answer;

  int get answerType => _answerType;

  EvaluationData(int questionId, double answer, int answerType) {
    _questionId = questionId;
    _answer = answer;
    _answerType = answerType;
  }

  EvaluationData.fromJson(dynamic json) {
    _questionId = json["question_id"];
    _answer = json["answer"];
    _answerType = json["answer_type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["question_id"] = _questionId;
    map["answer"] = _answer;
    map["answer_type"] = _answerType;
    return map;
  }

  @override
  String toString() {
    return 'EvaluationData{_questionId: $_questionId, _answer: $_answer, _answerType: $_answerType}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EvaluationData &&
          runtimeType == other.runtimeType &&
          _questionId == other._questionId &&
          _answer == other._answer &&
          _answerType == other._answerType;

  @override
  int get hashCode =>
      _questionId.hashCode ^ _answer.hashCode ^ _answerType.hashCode;
}
