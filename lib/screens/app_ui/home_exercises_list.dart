import 'package:bench_test_buddies/model/exercise_model.dart';
import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class HomeExerciseList extends StatefulWidget {
  @override
  _HomeExerciseListState createState() => _HomeExerciseListState();
}

class _HomeExerciseListState extends State<HomeExerciseList> {
  List<ExerciseModel> exercises = [];

  Future getAllExercise(context) async {
    if (exercises.isEmpty) {
      String token = Provider.of<UserLogData>(context, listen: false).token;
      await Provider.of<Exercises>(context, listen: false)
          .getAllExercise(token);
      Provider.of<Exercises>(context, listen: false).exercises.map((e) {
        return exercises.add(e);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          centerTitle: true,
          title: Text(
            'Home page',
            style: TextStyle(color: Color(0xFF1a1a4b), fontSize: 20),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: FutureBuilder(
            future: getAllExercise(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              } else
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2.0,
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 25),
                    itemCount: exercises.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () {
                          Provider.of<Exercises>(context,listen:false)
                              .initializeSelectedExercise(
                                  exercises[index].id,
                                  exercises[index].name,
                                  exercises[index].description);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        },
                        child: GridTile(
                            footer: Text(exercises[index].name),
                            child: Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.5,
                                ),
                              ),
                              child: Text(exercises[index].id.toString()),
                            )),
                      );
                    });
            }));
  }
}
