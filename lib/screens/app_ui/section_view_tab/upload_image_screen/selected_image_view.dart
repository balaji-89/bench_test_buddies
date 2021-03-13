import 'dart:io';

import 'package:bench_test_buddies/provider/exercise_stages.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import 'package:bench_test_buddies/screens/app_ui/section_view_tab/upload_image_screen/view_uploaded_images.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'image_delete_screen.dart';

class SelectedImageView extends StatefulWidget {
  List<File> selectedImages;

  SelectedImageView({this.selectedImages});

  @override
  _SelectedImageViewState createState() => _SelectedImageViewState();
}

class _SelectedImageViewState extends State<SelectedImageView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserLevel>(context, listen: true).userData;
    final currentExerciseStages =
        Provider.of<ExerciseStages>(context, listen: false)
            .findByStage(userData.currentSection);

    final popupMenuItem = <PopupMenuEntry>[
      PopupMenuItem(
        height: MediaQuery.of(context).size.height * 0.06,
        child: Text('Upload from Gallery',
            style: TextStyle(
              fontSize: 15,
            )),
        value: 0,
      ),
      PopupMenuDivider(
        height: 4,
      ),
      PopupMenuItem(
        height: MediaQuery.of(context).size.height * 0.06,
        child: Text('Take a photo',
            style: TextStyle(
              fontSize: 15,
            )),
        value: 1,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          iconTheme: IconThemeData(
            color: Color(0xff232323),
          ),
          centerTitle: true,
          title: Text(
            'Image Gallery',
            style: TextStyle(color: Color(0xff232323), fontSize: 18,fontWeight:FontWeight.w600),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          actions: <Widget>[
            PopupMenuButton(
              offset: Offset(0, 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              onSelected: (selectedIndex) {
                _popUpMenuAction(selectedIndex);
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.04,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'More',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              itemBuilder: (context) => popupMenuItem,
            ),
          ]),
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
                            itemCount: widget.selectedImages.length,
                            itemBuilder: (context, index) {
                              return index < 2
                                  ? GestureDetector(
                                      onLongPress: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              ImageDeletionScreen(
                                            selectedIndex: index,
                                            selectedImages:
                                                widget.selectedImages,
                                          ),
                                        ))
                                            .then((value) {
                                          setState(() {
                                            widget.selectedImages = value;
                                          });
                                        });
                                      },
                                      child: Container(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                0.49),
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.31),
                                        child: Image.file(
                                          widget.selectedImages[index],
                                          fit: BoxFit.cover,
                                        ),
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
                            itemCount: widget.selectedImages.length,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (index >= 2) {
                                return GestureDetector(
                                  onLongPress: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ImageDeletionScreen(
                                        selectedIndex: index,
                                        selectedImages: widget.selectedImages,
                                      ),
                                    ));
                                  },
                                  child: Container(
                                    width: (MediaQuery.of(context).size.width *
                                        0.33),
                                    height:
                                        (MediaQuery.of(context).size.height *
                                            0.31),
                                    child: Image.file(
                                        widget.selectedImages[index],
                                        fit: BoxFit.cover),
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
                          'Upload Images',
                          style: TextStyle(fontSize: 14),
                        ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            // String response= await Exercise().storeImages(
                            //      Provider.of<AttemptOfficial>(context,
                            //              listen: false)
                            //          .newCreatedAttempt,
                            //      Provider.of<Exercises>(context, listen: false)
                            //          .selectedExercise
                            //          .id,
                            //      widget.selectedImages,
                            //      Provider.of<UserLogData>(context,listen:false).token);
                            // print(' res[one $response');
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => UploadedImageView(
                                  uploadedImages: widget.selectedImages),
                            ));
                          } on Exception catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            print(e);
                          }
                        },
                      ))
                ],
              )),
    );
  }

  Future getCamera() async {
    var pickedImage;
    pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        widget.selectedImages.add(File(pickedImage.path));
      } else {}
    });
  }

  Future getGalleryImage() async {
    try {
      FilePickerResult pickedFiles = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        allowedExtensions: [
          'jpg',
          'png',
          'jpeg',
        ],
        type: FileType.custom,
      );
      if (pickedFiles != null) {
        if (pickedFiles.count <= 5 - widget.selectedImages.length) {
          setState(() {
            pickedFiles.paths
                .map((path) => widget.selectedImages.add(File(path)))
                .toList();
          });
        } else {
          showDialog(
              barrierColor: Colors.black12,
              barrierDismissible: true,
              context: context,
              builder: (context) => AlertDialog(
                    elevation: 5,
                    title: Text('Gallery limit reached'),
                    content: Text('Your selection should be below 5 files'),
                    actions: [
                      FlatButton(
                          child: Text(
                            'Delete files',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      FlatButton(
                        child: Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                  ));
        }
      }
    } catch (error) {
      print(error);
    }
  }

  void _popUpMenuAction(int value) {
    if (widget.selectedImages.length == 5) {
      showDialog(
          barrierColor: Colors.black12,
          barrierDismissible: true,
          context: context,
          builder: (context) => AlertDialog(
                elevation: 5,
                title: Text('Gallery limit reached'),
                content: Text(
                    'Kindly delete few images and free up the space to upload images'),
                actions: [
                  FlatButton(
                    child: Text(
                      'OK',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(0.7),
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
              ));
    } else {
      if (value == 0) {
        getGalleryImage();
      } else {
        getCamera();
      }
    }
  }
}
