import 'dart:convert';
import 'dart:io';

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
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'base_service.dart';

class Exercise {
  String baseUrl = 'https://innercircle.caapidsimplified.com/api';

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

  Future<String> emailVerification(String email, int code) async {
    try {
      http.Response response = await http.post('$baseUrl/email/verify', body: {
        'email': email,
        'code': code.toString(),
      });
      if (response.statusCode == 422) {
        throw Exception();
      }
      Map map = jsonDecode(response.body);
      return map["message"];
    } catch (error) {
      throw error;
    }
  }

  Future<String> resendEmailVerification(String email) async {
    try {
      http.Response response = await http.post('$baseUrl/email/resend', body: {
        'email': email,
      });
      if (response.statusCode == 422) {
        Map map = jsonDecode(response.body);
        throw map["message"];
      }
      Map map = jsonDecode(response.body);
      return map["message"];
    } catch (error) {
      throw error;
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

  Future<String> storeImages(
      int attemptId, int exerciseId, List<File> images, String token) async {
    var response;
    images.map((singleImage) async {
      try {
        var request = http.MultipartRequest(
            "POST", Uri.parse('$baseUrl/exercise/store-images'));
        String fileName = singleImage.path.split('/').last;
        request.files.add(http.MultipartFile(
          'images[]',
          singleImage.readAsBytes().asStream(),
          singleImage.lengthSync(),
          filename: fileName,
          contentType: MediaType('image', 'jpeg'),
        ));
        request.headers.addAll(
            {"Accept": "application/json", "Authorization": "Bearer $token"});
        request.fields.addAll({
          "attempt_id": attemptId.toString(),
          "exercise_id": exerciseId.toString()
        });
        return await request.send();
      } on Exception catch (error) {
        print(error);
        throw error;
      }
    }).toList();
  }

  Future<List> getAttemptTimeSummary(int attemptId, String token) async {
    try {
      http.Response response =
          await http.get('$baseUrl/exercise/time-summary/$attemptId', headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });
      var responseData = jsonDecode(response.body);
      return responseData["data"];
    } catch (error) {
      throw error;
    }
  }

  Future getEvaluationResultByAttempt(int attemptId, String token) async {
    try {
      http.Response response = await http
          .get("$baseUrl/evaluation/result/${attemptId.toString()}", headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      var convertedData = jsonDecode(response.body);
      print(convertedData["data"]);
      return convertedData["data"];
    } catch (error) {
      print('here $error');
      throw error;
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
      print(response.data['message']);
      return response.data['message'];
    } on DioError catch (err) {
      throw ErrorResponse(err.message);
    }
  }

  Future getAllBookmarks(String token) async {
    try {
      http.Response response = await http.get('$baseUrl/bookmark/get/all', headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          });
      print(response.body);
      var convertedData=jsonDecode(response.body);
      if(convertedData["message"].contains("you did't book marked any questions!")){
        return [];
      }
      return convertedData["data"];
    } catch (err) {
      print(err);
      throw json.decode(err);
    }
  }

  Future getBookmarkedData(int bookMarkedId, String token) async {
    try {
      http.Response response = await http.get(
        '$baseUrl/bookmark/get/$bookMarkedId', headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        });
      var convertedData = jsonDecode(response.body);
      return convertedData["data"];
    }  catch (error) {
      print(error);
      throw json.decode(error);
    }
  }

  Future unBookmark(int bookmarkId,String token)async{
    try{
      Response response = await dio.get(
        '/unbookmark/$bookmarkId',
        options: Options(headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        }),
      );
      return response.data["message"];
    }on DioError catch(error){
      throw error.message;
    }
  }

  Future getImages(int attemptId,String token)async{
      try{
        http.Response response =await http.get('$baseUrl/attemptImage/get/$attemptId',headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        });
        var convertedData=jsonDecode(response.body);
        return convertedData["data"];
      } catch(error){
        throw error["message"];
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

  Future createAttempt(int exerciseId, String token) async {
    try {
      http.Response response = await http.post('$baseUrl/attempt/create',
          body: {
            "exercise_id": exerciseId.toString()
          },
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          });
      dynamic convertedData = jsonDecode(response.body);
      return convertedData["data"];
    } catch (error) {
      throw error;
    }
  }

  Future getSolutionForAQuestion(String token, int evaluationId) async {
    try {
      http.Response response = await http.post(
          '$baseUrl/evaluation/solution/${evaluationId.toString()}',
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          });
      var convertedData = jsonDecode(response.body);
      return convertedData["data"];
    } catch (error) {
      throw (jsonDecode(error))["message"];
    }
  }

  Future<AttemptsResponse> getAttempts(int exerciseId, String token) async {
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
// http.Response response=await http.post('$baseUrl/exercise/store-images',headers: {
//   "Accept": "application/json",
//   "Authorization": "Bearer $token",
// },body: {
//   "images[]":formData.toString(),
//   "attempt_id":attemptId,
//   "exercise_id":exerciseId
// });
