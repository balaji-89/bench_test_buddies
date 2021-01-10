import 'package:bench_test_service/bench_test_service.dart';

class SignupQuestionResponse extends SuccessResponse {
  List<_Message> _message;

  List<_Message> get message => _message;

  SignupQuestionResponse({List<_Message> message}) {
    _message = message;
  }

  SignupQuestionResponse.fromJson(dynamic json) {
    if (json["message"] != null) {
      _message = [];
      json["message"].forEach((v) {
        _message.add(_Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_message != null) {
      map["message"] = _message.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'SignupQuestionResponse{_message: $_message}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignupQuestionResponse &&
          runtimeType == other.runtimeType &&
          _message == other._message;

  @override
  int get hashCode => _message.hashCode;
}

class _Message {
  int _id;
  String _question;
  List<_Answers> _answers;

  int get id => _id;

  String get question => _question;

  List<_Answers> get answers => _answers;

  _Message({int id, String question, List<_Answers> answers}) {
    _id = id;
    _question = question;
    _answers = answers;
  }

  _Message.fromJson(dynamic json) {
    _id = json["id"];
    _question = json["question"];
    if (json["answers"] != null) {
      _answers = [];
      json["answers"].forEach((v) {
        _answers.add(_Answers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["question"] = _question;
    if (_answers != null) {
      map["answers"] = _answers.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return '_Message{_id: $_id, _question: $_question, _answers: $_answers}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Message &&
          runtimeType == other.runtimeType &&
          _id == other._id &&
          _question == other._question &&
          _answers == other._answers;

  @override
  int get hashCode => _id.hashCode ^ _question.hashCode ^ _answers.hashCode;
}

class _Answers {
  int _id;
  String _answer;

  int get id => _id;

  String get answer => _answer;

  _Answers({int id, String answer}) {
    _id = id;
    _answer = answer;
  }

  _Answers.fromJson(dynamic json) {
    _id = json["id"];
    _answer = json["answer"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["answer"] = _answer;
    return map;
  }

  @override
  String toString() {
    return '_Answers{_id: $_id, _answer: $_answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Answers &&
          runtimeType == other.runtimeType &&
          _id == other._id &&
          _answer == other._answer;

  @override
  int get hashCode => _id.hashCode ^ _answer.hashCode;
}
