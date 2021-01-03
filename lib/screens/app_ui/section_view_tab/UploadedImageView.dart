import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class UploadedImageView extends StatefulWidget {
  List<Asset> selectedImages;
  File selectedFile ;

  UploadedImageView({this.selectedImages, this.selectedFile});

  @override
  _UploadedImageViewState createState() => _UploadedImageViewState();
}

class _UploadedImageViewState extends State<UploadedImageView> {
  List<File> fileObjects=[];
  Asset asset;

  Future changeAssetObjectToFileObject() async {
    widget.selectedImages.map((element) async {
      await FlutterAbsolutePath.getAbsolutePath(element.identifier)
          .then((value) {
        fileObjects.add(File(value));
      });
    });
  }

  @override
  void initState() {
    fileObjects.add(widget.selectedFile);
    if (widget.selectedImages.length != 0) {
      Future.delayed(Duration.zero, () async{
        await changeAssetObjectToFileObject();
      });


    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            color: Color(0xFF1a1a4b),
          ),
          centerTitle: true,
          title: Text(
            'Uploaded Images',
            style: TextStyle(color: Color(0xFF1a1a4b), fontSize: 20),
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
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                  ),
                ),
              ),
              itemBuilder: (context) => popupMenuItem,
            ),
          ]),
      body: SizedBox(
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
                        itemCount: fileObjects.length,
                        itemBuilder: (context, index) {
                          return index < 2
                              ? Container(
                                  width: (MediaQuery.of(context).size.width *
                                      0.49),
                                  height: (MediaQuery.of(context).size.height *
                                      0.31),
                                  decoration:BoxDecoration(

                                    image:DecorationImage(
                                        image:FileImage(
                                          fileObjects[index],
                                        ),
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
                        itemCount: fileObjects.length,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index >= 2) {
                            return Container(
                              width: (MediaQuery.of(context).size.width * 0.49),
                              height:
                                  (MediaQuery.of(context).size.height * 0.31),
                              child: Image.file(fileObjects[index]),
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
                    textColor: Colors.white,
                    color: Color(0xFF4667EE),
                    child: Text(
                      'Continue to Evaluate the results',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () async {},
                  ))
            ],
          )),
    );
  }

  List<Asset> multiImages = List<Asset>();

  Future getCamera() async {
    var pickedImage;
    pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (pickedImage != null) {
        //widget.selectedFile.add(File(pickedImage.path));
      } else {}
    });
  }

  Future getGalleryImage() async {
    List<Asset> resultList = List<Asset>();
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5 - fileObjects.length,
        selectedAssets: widget.selectedImages,
        materialOptions: MaterialOptions(
          actionBarColor: '#0d63db',
          selectionLimitReachedText: 'You reached maximum selection',
          statusBarColor: '#0d63db',
          actionBarTitle: "Select images",
          selectCircleStrokeColor: '#0d63db',
          allViewTitle: "All photos",
        ),
      );
    } catch (error) {
      print(error);
    }
    if (!mounted) return;
    setState(() {
      widget.selectedImages = resultList;
    });
  }

  void _popUpMenuAction(int value) {
    if (fileObjects.length == 5) {
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
