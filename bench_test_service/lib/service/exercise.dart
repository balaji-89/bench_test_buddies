import 'package:bench_test_service/model/request/store_attempt_request.dart';
import 'package:bench_test_service/model/request/store_evaluation_request.dart';
import 'package:bench_test_service/model/response/attempts_response.dart';
import 'package:bench_test_service/model/response/exercise_evaluation_response.dart';
import 'package:bench_test_service/model/response/response_exercise.dart';
import 'package:bench_test_service/model/response/response_exercise_info.dart';
import 'package:bench_test_service/model/response/response_status.dart';
import 'package:bench_test_service/model/response/solution_response.dart';
import 'package:bench_test_service/model/response/store_evaluation_response.dart';
import 'package:dio/dio.dart';

import 'base_service.dart';

class Exercise {
  Dio dio;

  Exercise() {
    dio = BaseService().getClient();
  }

  Future<List<ExerciseData>> getAllExercise(String token) async {
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

  Future<ResponseExerciseInfo> getExerciseInfo(
      int exerciseId, String token) async {

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

  Future<String> storeAttempt(
      StoreAttemptRequest attemptRequest, String token) async {
    try {
      Response response = await dio.post('/exercise/store',
          data: attemptRequest.toJson(),
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          }));
      return response.data['message'];
    } on DioError catch (err) {

      throw ErrorResponse.fromJson(err.response.data);
    }
  }

  Future<ExerciseEvaluationResponse> getExerciseEvaluation(
      int id, String token) async {
    try {
      Response response = await dio.get('/evaluation/questions/$id',
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          }));
      return ExerciseEvaluationResponse.fromJson(response.data);
    } on DioError catch (err) {
      throw ErrorResponse(err.message);
    }
  }

  Future<StoreEvaluationResponse> storeEvaluation(
      StoreEvaluationRequest evaluationRequest, String token) async {
    try {
      Response response = await dio.post('/evaluation/store',
          data: evaluationRequest,
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          }));
      return StoreEvaluationResponse.fromJson(response.data);
    } on DioError catch (err) {
      throw ErrorResponse(err.message);
    }
  }

  Future<String> saveBookmark(int evaluationId, String token) async {
    try {
      Response response = await dio.post('/bookmark/store',
          data: {"evaluation_id": evaluationId},
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          }));
      return response.data['message'];
    } on DioError catch (err) {
      throw ErrorResponse(err.message);
    }
  }

  /// The Parameter [option] takes only values "all", "correct" and "incorrect"
  Future<SolutionResponse> getSolution(String option, String token) async {
    try {
      Response response = await dio.get('/evaluation/user/answer?sort=$option',
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          }));
      return SolutionResponse.fromJson(response.data);
    } on DioError catch (err) {
      throw ErrorResponse(err.message);
    }
  }

  Future<AttemptsResponse> getAttempts(int exerciseId,String token) async {
    try {
      Response response = await dio.get('/attempts/get/all/$exerciseId',
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          }));
      return AttemptsResponse.fromJson(response.data);
    } on DioError catch (err) {
      throw ErrorResponse(err.message);
    }
  }
}
