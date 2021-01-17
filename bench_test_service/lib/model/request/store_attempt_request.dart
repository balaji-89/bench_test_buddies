/// api_excercise_id : 3
/// last_completed_section : 2
/// start_time : "00:50:00"
/// end_time : "00:10:00"
/// initial_time_set : "00:50:00"
/// actual_time_taken : "00:40:00"
/// extra_time_taken : "00:00:00"

class StoreAttemptRequest {
  int _apiExcerciseId;
  int _lastCompletedSection;
  String _startTime;
  String _endTime;
  String _initialTimeSet;
  String _actualTimeTaken;
  String _extraTimeTaken;

  int get apiExcerciseId => _apiExcerciseId;

  int get lastCompletedSection => _lastCompletedSection;

  String get startTime => _startTime;

  String get endTime => _endTime;

  String get initialTimeSet => _initialTimeSet;

  String get actualTimeTaken => _actualTimeTaken;

  String get extraTimeTaken => _extraTimeTaken;

  StoreAttemptRequest(
      int apiExcerciseId,
      int lastCompletedSection,
      String startTime,
      String endTime,
      String initialTimeSet,
      String actualTimeTaken,
      String extraTimeTaken) {
    _apiExcerciseId = apiExcerciseId;
    _lastCompletedSection = lastCompletedSection;
    _startTime = startTime;
    _endTime = endTime;
    _initialTimeSet = initialTimeSet;
    _actualTimeTaken = actualTimeTaken;
    _extraTimeTaken = extraTimeTaken;
  }

  StoreAttemptRequest.fromJson(dynamic json) {
    _apiExcerciseId = json["api_excercise_id"];
    _lastCompletedSection = json["last_completed_section"];
    _startTime = json["start_time"];
    _endTime = json["end_time"];
    _initialTimeSet = json["initial_time_set"];
    _actualTimeTaken = json["actual_time_taken"];
    _extraTimeTaken = json["extra_time_taken"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["api_excercise_id"] = _apiExcerciseId;
    map["last_completed_section"] = _lastCompletedSection;
    map["start_time"] = _startTime;
    map["end_time"] = _endTime;
    map["initial_time_set"] = _initialTimeSet;
    map["actual_time_taken"] = _actualTimeTaken;
    map["extra_time_taken"] = _extraTimeTaken;
    return map;
  }
}
