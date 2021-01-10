import 'package:bench_test_service/bench_test_service.dart';

class CountryResponse extends SuccessResponse {
  List<_Data> _data;

  @override
  String toString() {
    return 'CountryResponse{_data: $_data}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryResponse &&
          runtimeType == other.runtimeType &&
          _data == other._data;

  @override
  int get hashCode => _data.hashCode;

  List<_Data> get data => _data;

  CountryResponse({List<_Data> data}) {
    _data = data;
  }

  CountryResponse.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(_Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class _Data {
  int _id;
  String _name;

  int get id => _id;

  String get name => _name;

  _Data({int id, String name}) {
    _id = id;
    _name = name;
  }

  _Data.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

  @override
  String toString() {
    return '_Data{_id: $_id, _name: $_name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Data &&
          runtimeType == other.runtimeType &&
          _id == other._id &&
          _name == other._name;

  @override
  int get hashCode => _id.hashCode ^ _name.hashCode;
}
