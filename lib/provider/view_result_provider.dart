import 'package:bench_test_service/service/exercise.dart';
import 'package:flutter/material.dart';

class ViewResultProvider with ChangeNotifier{

  var all;
  var correct;
  var inCorrect;
  var bookMarks;



  Future<void> initializeData(String token)async {
    print('called');
     try{
       all=await Exercise().getSolution("all",token);
       print(all);
       correct= await Exercise().getSolution("correct",token);
       inCorrect=await Exercise().getSolution("incorrect",token);
     }catch(error){
       print(error.message);
     }
  }
}