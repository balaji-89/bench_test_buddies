class ErrorResponse extends Error {
  String message;

  ErrorResponse(this.message);

  ErrorResponse.fromJson(dynamic json) {
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["message"] = message;
    return map;
  }
}

class SuccessResponse {
  final message;

  SuccessResponse({this.message});
}
