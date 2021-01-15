import 'package:bench_test_service/bench_test_service.dart';
import 'package:bench_test_service/model/response/countries.dart';
import 'package:bench_test_service/model/response/get_user_response.dart';
import 'package:bench_test_service/model/response/response_exercise.dart';
import 'package:bench_test_service/model/response/signup_question_response.dart';
import 'package:bench_test_service/service/exercise.dart';
import 'package:dio/dio.dart';

void main() async {
  String token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDQ2NmJmOTE3YjFjMjcwMTRlNjVkYzE3NzM3YjJjYWY5OWQ0MDIwYWI2ODdkODQwNmJlMDIyYjQ5MjA5MzE2OTAwMjNkZGM0NzNhYjY2NzAiLCJpYXQiOjE2MDgzNzUwMTYsIm5iZiI6MTYwODM3NTAxNiwiZXhwIjoxNjM5OTExMDE2LCJzdWIiOiIzNDIiLCJzY29wZXMiOltdfQ.vwLMuaFSEljuvyu1S0ya57lQb2YDrO5xhvOAC6keF49yQwIzhpQ_lp7F0_XsKrfOaffdIn8OKkR4eFofh5hrCkMfbCgXBhxyqvwonu62WWMhFqM0xMZs4u9L6iUcJGekxKTJvnnQ_9V_4mB4_oF4qHT0Y9hPu3LfTW5oYcyN-lcOmfeGZktWIqPOonEWK00YvudfzYx9mBUbiGWMmpqsXRc80gyvW5lJFgICMuxdvD5JUQTsuh_yPRK5Ve73puhiJJ9MDVF0HYqKtoe6_d0NyfZPwIKP-8Ftx1tZPsg-Vccdk4lBDfFZUPOuUnULuSRkK-QUfgcW7BpXNV5Gcp5Pkmbq-u0IfOArKT1efi1qCqkntKEtKYIONIQgE5w1ReyovnPwZROR-usceDRJLDZ4qTY7tGv6mNQHHeaDgbELo9UTYas38AWDZeXpa0hGUCUSYpn_dgUHBbxDzsiCKSOF99rfh5jiaHBzTF6UXcNHA-LcmAfKwXtHKw9Lp0AfkH6qpc2V4Jb0jdGe_Vb9465FaaG0rjrHDh5E2pOar5ofYX-VdXLa0r-hrBIZAqOJE8L2QSJHSGflTMLAUDprBHgaBa0xqPZFT8DR4O7ZgE-WMEmArWV0oE_Fb7bJWYNg_4BM8xFCDuLhv2Xk9LKe8JGv8iU7DgI4tdrwgcxMJC4KJrE';
  try {
    var response = await Exercise().getExerciseInfo(1, token);
    print(response);
  } on ErrorResponse catch (err) {
    print('Error:');
    print(err.toJson());
  }
}
