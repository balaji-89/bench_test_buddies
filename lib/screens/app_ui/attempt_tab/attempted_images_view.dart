import 'package:bench_test_buddies/model/attempted_images.dart';
import 'package:bench_test_buddies/provider/attempt_official_provider.dart';
import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttemptedImagesView extends StatefulWidget {
  @override
  _AttemptedImagesViewState createState() => _AttemptedImagesViewState();
}

class _AttemptedImagesViewState extends State<AttemptedImagesView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserLevel>(context, listen: true).userData;
    final currentExerciseStages =
        Provider.of<ExerciseStages>(context, listen: false)
            .findByStage(userData.currentSection);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF1a1a4b),
        ),
        centerTitle: true,
        title: Text(
          'Uploaded Images',
          style: TextStyle(
              color: Color(0xFF232323),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: FutureBuilder(
          future: Provider.of<AttemptOfficial>(context, listen: false)
              .getAttemptedImages(
                  Provider.of<UserLogData>(context, listen: false).token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.31,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              padding: EdgeInsets.all(0),
                              separatorBuilder: (context, index) => SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.015,
                              ),
                              scrollDirection: Axis.horizontal,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return index < 2
                                    ? Container(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                0.49),
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.31),
                                        child: Text(
                                          snapshot.data[index].imagePath,
                                        ),
                                      )
                                    : null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.007,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.185,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                              padding: EdgeInsets.all(0),
                              separatorBuilder: (context, index) => SizedBox(
                                width: index >= 2
                                    ? MediaQuery.of(context).size.width * 0.01
                                    : 0,
                              ),
                              itemCount: snapshot.data.length,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (index >= 2) {
                                  return Container(
                                    width: (MediaQuery.of(context).size.width *
                                        0.33),
                                    height:
                                        (MediaQuery.of(context).size.height *
                                            0.31),
                                    child: Text(
                                      snapshot.data[index].imagePath,
                                    ),
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ));
          }),
    );
  }
}
