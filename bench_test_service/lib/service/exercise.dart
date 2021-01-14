import 'package:bench_test_service/model/response/response_exercise.dart';
import 'package:bench_test_service/model/response/response_exercise_info.dart';
import 'package:bench_test_service/model/response/response_status.dart';
import 'package:dio/dio.dart';

import 'base_service.dart';

class Exercise {
  Dio dio;

  Exercise() {
    dio = BaseService().getClient();
  }

  getAllExercise(String token) async {
    try {
      Response response = await dio.get('/exercise/all',
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          }));
      return ResponseExercise.fromJson(response.data).exercises;
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  getExerciseInfo(int exerciseId, String token) async {
    try {
      Response response = await dio.get('/exercise/data/$exerciseId',
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          }));
      return ResponseExerciseInfo.fromJson(response.data['data']);
    } on DioError catch (err) {
      throw ErrorResponse.fromJson(err.response.data);
    }
  }
}
