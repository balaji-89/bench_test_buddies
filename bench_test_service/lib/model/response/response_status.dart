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

  @override
  String toString() {
    return 'ErrorResponse{message: $message}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorResponse &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

class SuccessResponse {
  final message;

  SuccessResponse({this.message});
}
