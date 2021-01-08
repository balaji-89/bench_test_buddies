import 'dart:io';

import 'package:flutter/material.dart';

class ImageDeletionScreen extends StatefulWidget {
  final selectedImages;
  final int selectedIndex;

  ImageDeletionScreen(
      {@required this.selectedImages, @required this.selectedIndex});

  @override
  _ImageDeletionScreenState createState() => _ImageDeletionScreenState();
}

class _ImageDeletionScreenState extends State<ImageDeletionScreen> {
  List<int> deleteList = [];

  void clickFunction(int index) {
    if (checkingValueInDeleteList(index)) {
      removeFromDeleteList(index);
    } else {
      addTODeleteList(index);
    }
  }

  @override
  void initState() {
    deleteList.add(widget.selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('${deleteList.length} images selected'),
          centerTitle: false,
          actions: <Widget>[
            InkWell(
              onTap: deleteImages,
              child: Container(
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.04,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Delete',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                                ? InkWell(
                                    onTap: () {
                                      clickFunction(index);
                                    },
                                    child: LayoutBuilder(
                                        builder: (context, constraints) {
                                      return Stack(
                                        children: [
                                          Container(
                                            width: (MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                          if (deleteList.contains(index))
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: constraints.maxHeight *
                                                        0.85,
                                                    left: 10),
                                                child: CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: AssetImage(
                                                    'assets/on_boarding_images/RectangleSelect.png',
                                                  ),
                                                ))
                                        ],
                                      );
                                    }),
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
                              return InkWell(
                                onTap: () {
                                  clickFunction(index);
                                },
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return Stack(
                                    children: [
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                0.33),
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.31),
                                        child: Image.file(
                                            widget.selectedImages[index],
                                            fit: BoxFit.cover),
                                      ),
                                      if (deleteList.contains(index))
                                        Padding(
                                            padding: EdgeInsets.only(
                                              top: constraints.maxHeight * 0.7,
                                              left:
                                                  constraints.maxHeight * 0.05,
                                            ),
                                            child: CircleAvatar(
                                              radius: 10,
                                              backgroundColor: Colors.white,
                                              backgroundImage: AssetImage(
                                                'assets/on_boarding_images/RectangleSelect.png',
                                              ),
                                            ))
                                    ],
                                  );
                                }),
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
            )));
  }

  void addTODeleteList(int indexValue) {
    setState(() {
      deleteList.add(indexValue);
    });
  }

  void removeFromDeleteList(indexValue) {
    setState(() {
      deleteList.remove(indexValue);
    });
  }

  bool checkingValueInDeleteList(int index) {
    return deleteList.any((element) => element == index);
  }

  void deleteImages() {
    var filteredImages=[];
    deleteList.map((element) {
      File particularImage = widget.selectedImages[element];
      filteredImages.addAll(widget.selectedImages.remove(particularImage));
    });
    print('length ${filteredImages.length}');
    Navigator.of(context).pop(filteredImages);
  }
}
