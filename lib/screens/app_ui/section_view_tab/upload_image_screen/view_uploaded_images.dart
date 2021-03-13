import 'dart:io';

import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/Evaluationscreen/evaluation_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadedImageView extends StatefulWidget {
  List<File> uploadedImages;

  UploadedImageView({this.uploadedImages});

  @override
  _UploadedImageViewState createState() => _UploadedImageViewState();
}

class _UploadedImageViewState extends State<UploadedImageView> {
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
          style: TextStyle(color: Color(0xFF232323), fontSize: 18,fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : SizedBox(
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
                              width: MediaQuery.of(context).size.width * 0.015,
                            ),
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.uploadedImages.length,
                            itemBuilder: (context, index) {
                              return index < 2
                                  ? Container(
                                      width:
                                          (MediaQuery.of(context).size.width *
                                              0.49),
                                      height:
                                          (MediaQuery.of(context).size.height *
                                              0.31),
                                      child: Image.file(
                                        widget.uploadedImages[index],
                                        fit: BoxFit.cover,
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
                            itemCount: widget.uploadedImages.length,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (index >= 2) {
                                return Container(
                                  width: (MediaQuery.of(context).size.width *
                                      0.33),
                                  height: (MediaQuery.of(context).size.height *
                                      0.31),
                                  child: Image.file(
                                      widget.uploadedImages[index],
                                      fit: BoxFit.cover),
                                );
                              }
                              return SizedBox();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.04),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        elevation: 0,
                        textColor: Colors.white,
                        color: Color(0xFF4667EE),
                        child: Text(
                          'Continue to Evaluate the results',
                          style: TextStyle(fontSize: 14),
                        ),
                        onPressed: () {
                          Provider.of<UserLevel>(context, listen: false)
                              .changeUserStage(currentExerciseStages['step']);
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => EvaluationHome(),
                          ));
                        },
                      ))
                ],
              )),
    );
  }
}
