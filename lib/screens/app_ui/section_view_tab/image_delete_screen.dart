import'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class ImageDeletionScreen extends StatefulWidget {
  final selectedImages;

  ImageDeletionScreen({@required this.selectedImages});
  @override
  _ImageDeletionScreenState createState() => _ImageDeletionScreenState();
}

class _ImageDeletionScreenState extends State<ImageDeletionScreen> {
  final deleteList=[];
  void addTODeleteList(int indexValue){
    deleteList.add(indexValue);
  }

  void removeFromDeleteList(indexValue){
    deleteList.remove(indexValue);
  }


  bool checkingValueInDeleteList(int index){
    return deleteList.any((element) => element==index);
  }

  void clickFunction(int index){
    if(checkingValueInDeleteList(index)){
        removeFromDeleteList(index);
    }else{
      addTODeleteList(index);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),

          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: Text('${deleteList.length} images selected'),
          centerTitle: false,

          actions: <Widget>[
            InkWell(
              onTap: (){},
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
                                  onTap:(){
                                    clickFunction(index);
                                  },
                                  child: Stack(
                                    children: [
                                      AssetThumb(
                                      asset: widget.selectedImages[index],
                                      width: (MediaQuery.of(context).size.width *
                                          0.497)
                                          .toInt(),
                                      height: (MediaQuery.of(context).size.height *
                                          0.31)
                                          .toInt()),
                                      if(checkingValueInDeleteList(index))
                                      Positioned(
                                         
                                          child: Icon(Icons.check_circle)),
                                    ],

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
            ))
    );
  }
}
