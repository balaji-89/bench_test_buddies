import 'package:flutter/material.dart';

enum Stages {
  Start_the_exercise,
  Uploaded_images,
  Evaluate_the_result,
  View_the_results,
}

class ExerciseStages with ChangeNotifier {
  List<Map> _stages = [

    {
      'position':'1',
      'step': Stages.Start_the_exercise,
      'stage': 'Start the excerise',
      'icon': 'assets/Home_page_images/spaceship.png',
    },
    {
      'position':'2',
      'step': Stages.Uploaded_images,
      'stage': 'Uploaded images',
      'icon': 'assets/Home_page_images/upload.png'
    },
    {
      'position':'3',
      'step': Stages.Evaluate_the_result,
      'stage': 'Evaluate the results',
      'icon': 'assets/Home_page_images/Questions.png'
    },
    {
      'position':'4',
      'step': Stages.View_the_results,
      'stage': 'View the results',
      'icon': 'assets/Home_page_images/ezgif.com-gif-maker.png'
    },
  ];

  List<Map> get stages{
    return [..._stages];
  }

  Map findByStage(data) {
    return stages.firstWhere((element) => element['step'] == data);
  }

  List<dynamic> findByStages(List data) {
    List foundedData = [];
    for (var i = 0; i < data.length; i++) {
      foundedData
          .add(stages.firstWhere((element) => element['step'] == data[i]));
    }
    return foundedData;
  }
  
  List<int> get getPositionsOfExerciseStages{
    List<int> position=[];
    for(var i=0;i<_stages.length;i++){
      var value=( _stages[i]["position"]);
      position.add(int.parse(value));
    }
    return position;
  }
}
