import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class UploadedImageView extends StatefulWidget {
  List<Asset> selectedImages;

  UploadedImageView({@required this.selectedImages});

  @override
  _UploadedImageViewState createState() => _UploadedImageViewState();
}

class _UploadedImageViewState extends State<UploadedImageView> {
  @override
  Widget build(BuildContext context) {
    var clickedImage;

    List<Asset> multiImages = List<Asset>();

    Future getCamera() async {
      var pickedImage;
      pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
      setState(() {
        if (pickedImage != null) {
          clickedImage = File(
            pickedImage.path,
          );
        } else {}
      });
    }

    Future getGalleryImage() async {
      List<Asset> resultList = List<Asset>();
      try {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 5 - (widget.selectedImages.length),
          selectedAssets: multiImages,
          materialOptions: MaterialOptions(
            actionBarColor: '#0d63db',
            selectionLimitReachedText: 'You reached maximum selection',
            statusBarColor: '#0d63db',
            actionBarTitle: "Select images",
            selectCircleStrokeColor: '#0d63db',
            allViewTitle: "All photos",
          ),
        ).then((value) {
          setState(() {
            value.map((element){
              widget.selectedImages.add(element);
            });
          });
          return ;
        });
      } catch(error) {
        print(error);
      }
      if(!mounted) return;
      setState(() {
        resultList.map((element){
          widget.selectedImages.add(element);
        });

      });
    }

    final popupMenuItem = <PopupMenuEntry>[
      PopupMenuItem(
        height: MediaQuery.of(context).size.height * 0.06,
        child: InkWell(
          onTap: () {
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
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7),

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
              getGalleryImage();
            }
          },
          child: Text('Upload from Gallery',
              style: TextStyle(
                fontSize: 15,
              )),
        ),
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
      ),
    ];

    _showPopUpMenu() async {
      await showMenu(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        context: context,
        position: RelativeRect.fromLTRB(
            MediaQuery.of(context).size.width * 0.8,
            MediaQuery.of(context).size.height * 0.13,
            MediaQuery.of(context).size.width * 0.03,
            0),
        items: popupMenuItem,
        elevation: 8,
      );
    }

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
            InkWell(
              onTap: _showPopUpMenu,
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
                        itemCount: widget.selectedImages.length,
                        itemBuilder: (context, index) {
                          return index < 2
                              ? AssetThumb(
                                  asset: widget.selectedImages[index],
                                  width: (MediaQuery.of(context).size.width *
                                          0.497)
                                      .toInt(),
                                  height: (MediaQuery.of(context).size.height *
                                          0.31)
                                      .toInt())
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
                            return AssetThumb(
                                asset: widget.selectedImages[index],
                                width:
                                    (MediaQuery.of(context).size.width * 0.33)
                                        .toInt(),
                                height:
                                    (MediaQuery.of(context).size.height * 0.185)
                                        .toInt());
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
}
