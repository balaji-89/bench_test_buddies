import 'dart:io';

import 'package:bench_test_buddies/screens/app_ui/section_view_tab/upload_image_screen/UploadedImageView.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../home.dart';

class PractisedImages extends StatefulWidget {
  @override
  _PractisedImagesState createState() => _PractisedImagesState();
}

class _PractisedImagesState extends State<PractisedImages> {
  var image;
  bool isLoading=false;

  Widget button(String label, constraints) {
    return Container(
        height: constraints.maxHeight * 0.07,
        width: constraints.maxWidth,
        margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.04),
        child: RaisedButton(
          textColor: Colors.white,
          color: Color(0xFF4667EE),
          child: Text(
            label,
            style: TextStyle(fontSize: 14),
          ),
          onPressed: () async {
            if (label == 'Take a Photo') {
              await getCamera();
            } else {
              await getGalleryImage();
            }
          },
        ));
  }

  Future getCamera() async {
    setState(() {
      isLoading=true;
    });
    var clickedImage = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      isLoading=true;
    });
    if (clickedImage != null) {
      var image = File(clickedImage.path);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => UploadedImageView(selectedImages: [image])));
    }
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
         if(pickedFiles.count<=5) {
           List<File> files = pickedFiles.paths.map((path) => File(path))
               .toList();
           Navigator.of(context).pushReplacement(MaterialPageRoute(
               builder: (context) =>
                   UploadedImageView(
                     selectedImages: files,
                   )));
         }else{
           showDialog(
               barrierColor: Colors.black12,
               barrierDismissible: true,
               context: context,
               builder: (context) => AlertDialog(
                 elevation: 5,
                 title: Text('Limit exceeded'),
                 content: Text(
                     'Your selection should be below 5 files'),
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

         }
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text('Practised Images',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
                letterSpacing: 0.2)),
        elevation: 1,
        centerTitle: true,
        titleSpacing: 0.3,
      ),
      body: isLoading==true?Center(child:CircularProgressIndicator(
        backgroundColor: Theme.of(context).primaryColor,
      
      )):SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.1,
                width: constraints.maxWidth,
                child: Center(
                  child: Text('Class 1 Amalgam Cavity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      )),
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.01,
                width: constraints.maxWidth,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.3,
                width: constraints.maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button('Take a Photo', constraints),
                    SizedBox(
                      height: constraints.maxHeight * 0.13,
                      width: constraints.maxWidth * 0.88,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Divider(
                                color: Colors.grey,
                              )),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'OR',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Expanded(flex: 3, child: Divider(color: Colors.grey)),
                        ],
                      ),
                    ),
                    button('Choose from existing photo', constraints)
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
