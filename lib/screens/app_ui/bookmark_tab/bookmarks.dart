import 'package:bench_test_buddies/model/solution_model.dart';
import 'package:bench_test_buddies/provider/user_data_token.dart';
import 'package:bench_test_buddies/provider/view_result_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookMarks extends StatefulWidget {
  @override
  _BookMarksState createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  final Map<String, bool> checkBoxItems = {
    'All': false,
    'Correct': false,
    'Incorrect': false
  };
  List checkBoxKeys;


  List<int> bookMarksList = [];
  var selectedBookmarkId;
  Solution detailsOfBookmarkedItem;
  String token ;

  @override
  void initState() {
    token= Provider.of<UserLogData>(context, listen: false).token;
    bookMarksList= Provider.of<BookmarksProvider>(context, listen: false).bookmarks;
    if(bookMarksList.isNotEmpty){
    selectedBookmarkId = bookMarksList[0];}
    checkBoxKeys = checkBoxItems.keys.toList();
    super.initState();
  }

  Future onTapContainer(int selectedId) async {
    detailsOfBookmarkedItem = await Provider.of<BookmarksProvider>(context, listen: false)
            .getBookmarkedItem(selectedId, token);
  }

  void changeCheckBoxState(String char, bool changedValue) {
    checkBoxItems.forEach((key, value) {
      setState(() {
        if (key == char) {
          checkBoxItems.update(key, (value) => changedValue);
        } else {
          checkBoxItems.update(key, (value) => !changedValue);
        }
      });
    });
  }

  Widget divider(mediaQuerySize) {
    return Container(
      height: mediaQuerySize.height * 0.01,
      width: mediaQuerySize.width,
      color: Theme.of(context).accentColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
        body: bookMarksList.isEmpty||null?Center(
          child:Text('Add Bookmarks to show',style: TextStyle(
            fontWeight:FontWeight.w600,
            fontSize:18,
            color:Color(0xff232323),
          ),)
        ):Column(
      children: [
        SizedBox(
          height: mediaQuery.height * 0.1,
          width: mediaQuery.width,
          child: ListView.builder(
              itemCount: bookMarksList.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12.5),
              itemBuilder: (ctx, i) {
                return InkWell(
                  onTap: () async {
                    setState(() {
                      selectedBookmarkId = bookMarksList[i];
                    });
                  },
                  child: Container(
                    height: mediaQuery.height * 0.007,
                    width: mediaQuery.width * 0.08,
                    margin: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: selectedBookmarkId == bookMarksList[i]
                          ? Color(0xfff79703)
                          : Color(0xffffffff),
                      border: Border.all(color: Color(0xfff79703), width: 1),
                    ),
                    child: Center(
                        child: Text(
                      '${bookMarksList[i]}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: selectedBookmarkId == bookMarksList[i]
                              ? Color(0xffffffff)
                              : Color(0xff232323)),
                    )),
                  ),
                );
              }),
        ),
        divider(mediaQuery),
        SizedBox(
          height: mediaQuery.height*0.68,
          width: mediaQuery.width,
          child:FutureBuilder(
                future: onTapContainer(selectedBookmarkId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                  return ListView(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width,
                      child: LayoutBuilder(
                        builder: (context, constraints) => Column(
                          children: [
                            SizedBox(
                              height: constraints.maxHeight * 0.15,
                              width: constraints.maxWidth,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 15, top: 8, bottom: 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${detailsOfBookmarkedItem.question}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).primaryColor),
                                    ),
                                    Text(
                                      'Your response: ${detailsOfBookmarkedItem.userAnswer}',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.red),
                                    ),
                                    Text(
                                      //TODO:exact answer have to integrate
                                      'Correct answer: No',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.green),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            divider(mediaQuery),
                            SizedBox(
                              height: constraints.maxHeight * 0.11,
                              child: ListTile(
                                leading: Container(
                                  height: constraints.maxHeight * 0.09,
                                  width: constraints.maxWidth * 0.13,
                                  margin: EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                      color: Color(0xff232323),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7),
                                      )),
                                ),
                                title: Text(
                                  "" == ""
                                      ? 'Click to view the full image'
                                      : 'Click to view the video',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                trailing: IconButton(
                                  padding: EdgeInsets.all(0),
                                  alignment: Alignment.centerRight,
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xff232323),
                                    size: 18,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            divider(mediaQuery),
                            Container(
                                height: constraints.maxHeight * 0.19,
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Explanation :',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text('${detailsOfBookmarkedItem.explanation}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color(0xff232323),
                                        )),
                                  ],
                                )),
                            divider(mediaQuery),
                            Container(
                                height: constraints.maxHeight * 0.15,
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 7),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Common cause for the error :',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text("${detailsOfBookmarkedItem.commonErrorCause}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color(0xff232323),
                                        )),
                                  ],
                                )),
                            divider(mediaQuery),
                            Container(
                                height: constraints.maxHeight * 0.12,
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 7),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'How to prevent the error :',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text('${detailsOfBookmarkedItem.prevent}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color(0xff232323),
                                        )),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    )
                  ]);
                }),

        ),
      ],
    ));
  }
}
