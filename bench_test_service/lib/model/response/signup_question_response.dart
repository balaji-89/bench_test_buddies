class SignupQuestionResponse {
  String _message;
  Data _data;

  String get message => _message;

  Data get data => _data;

  SignupQuestionResponse({String message, Data data}) {
    _message = message;
    _data = data;
  }

  SignupQuestionResponse.fromJson(dynamic json) {
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
}

class Data {
  One _one;
  Two _two;

  One get one => _one;

  Two get two => _two;

  Data({One one, Two two}) {
    _one = one;
    _two = two;
  }

  Data.fromJson(dynamic json) {
    _one = json["1"] != null ? One.fromJson(json["1"]) : null;
    _two = json["2"] != null ? Two.fromJson(json["2"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_one != null) {
      map["1"] = _one.toJson();
    }
    if (_two != null) {
      map["2"] = _two.toJson();
    }
    return map;
  }
}

class Two {
  List<ExpertiseLevel> _expertiseLevel;

  List<ExpertiseLevel> get expertiseLevel => _expertiseLevel;

  Two({List<ExpertiseLevel> expertiseLevel}) {
    _expertiseLevel = expertiseLevel;
  }

  Two.fromJson(dynamic json) {
    if (json["Enter your Expertise level in bench preparation"] != null) {
      _expertiseLevel = [];
      json["Enter your Expertise level in bench preparation"].forEach((v) {
        _expertiseLevel.add(ExpertiseLevel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_expertiseLevel != null) {
      map["Enter your Expertise level in bench preparation"] =
          _expertiseLevel.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ExpertiseLevel {
  String _one;

  String get one => _one;

  ExpertiseLevel({String one}) {
    _one = one;
  }

  ExpertiseLevel.fromJson(dynamic json) {
    _one = json["1"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["1"] = _one;
    return map;
  }
}

class One {
  List<ProfessionalBench> _professionalBench;

  List<ProfessionalBench> get professionalBench => _professionalBench;

  One({List<ProfessionalBench> professionalBench}) {
    _professionalBench = professionalBench;
  }

  One.fromJson(dynamic json) {
    if (json["Have you attended the professional bench test course?"] != null) {
      _professionalBench = [];
      json["Have you attended the professional bench test course?"]
          .forEach((v) {
        _professionalBench.add(ProfessionalBench.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_professionalBench != null) {
      map["Have you attended the professional bench test course?"] =
          _professionalBench.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ProfessionalBench {
  String _one;

  String get one => _one;

  ProfessionalBench({String one}) {
    _one = one;
  }

  ProfessionalBench.fromJson(dynamic json) {
    _one = json["1"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["1"] = _one;
    return map;
  }
}
