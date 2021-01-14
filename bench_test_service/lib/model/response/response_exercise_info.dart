class ResponseExerciseInfo {
  int _id;
  String _name;
  String _description;
  int _lastCompletedSection;

  int get id => _id;

  String get name => _name;

  String get description => _description;

  int get lastCompletedSection => _lastCompletedSection;

  ResponseExerciseInfo(
      {int id, String name, String description, int lastCompletedSection}) {
    _id = id;
    _name = name;
    _description = description;
    _lastCompletedSection = lastCompletedSection;
  }

  ResponseExerciseInfo.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _description = json["description"];
    _lastCompletedSection = json["last_completed_section"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["description"] = _description;
    map["last_completed_section"] = _lastCompletedSection;
    return map;
  }

  @override
  String toString() {
    return 'ResponseExerciseInfo{_id: $_id, _name: $_name, _description: $_description, _lastCompletedSection: $_lastCompletedSection}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseExerciseInfo &&
          runtimeType == other.runtimeType &&
          _id == other._id &&
          _name == other._name &&
          _description == other._description &&
          _lastCompletedSection == other._lastCompletedSection;

  @override
  int get hashCode =>
      _id.hashCode ^
      _name.hashCode ^
      _description.hashCode ^
      _lastCompletedSection.hashCode;
}
