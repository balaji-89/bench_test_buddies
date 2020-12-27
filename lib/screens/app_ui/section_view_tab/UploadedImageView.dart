import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class UploadedImageView extends StatelessWidget {
  final selectedImages;

  UploadedImageView({@required this.selectedImages});

  final popupMenuItem = <PopupMenuEntry>[
    PopupMenuItem(
      child: Text('Upload from Gallery'),
    ),
    PopupMenuItem(
      child: Text('Take a photo'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
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
              itemBuilder: (context) => popupMenuItem,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Text(
                'More',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ]),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: selectedImages.length,
          itemBuilder: (context, index) => Container(
            child: AssetThumb(
              asset: selectedImages[index],
              width: 150,
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}
