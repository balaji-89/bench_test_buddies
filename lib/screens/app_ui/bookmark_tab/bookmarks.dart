import'package:flutter/material.dart';
class BookMarks extends StatefulWidget {


  @override
  _BookMarksState createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  @override
  Widget build(BuildContext context) {
    final List numbers = [
      2,
      8,
      11,
      12,
      14,
      16,
    ];
    final Map<String, bool> checkBoxItems = {
      'All': false,
      'Correct': false,
      'Incorrect': false
    };
    final checkBoxKeys = checkBoxItems.keys.toList();

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

    Widget divider(constraints) {
      return Container(
        height: constraints.maxHeight * 0.01,
        width: constraints.maxWidth,
        color: Theme.of(context).accentColor,
      );
    }
    return Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                divider(constraints),
                SizedBox(
                  height: constraints.maxHeight * 0.13,
                  width: constraints.maxWidth,
                  child: ListView.builder(
                      padding: EdgeInsets.only(left: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: numbers.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Center(
                          child: Container(
                            height: constraints.maxHeight * 0.05,
                            width: constraints.maxWidth * 0.09,
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 1.3),
                              color: Colors.white,
                            ),
                            child: Text(
                              numbers[index].toString(),
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ))),
                ),
                divider(constraints),
                SizedBox(
                  height: constraints.maxHeight * 0.17,
                  width: constraints.maxWidth,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 8, bottom: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question?',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          'wrong Answer',
                          style: TextStyle(fontSize: 15, color: Colors.red),
                        ),
                        Text(
                          'Correct answer',
                          style: TextStyle(fontSize: 15, color: Colors.green),
                        )
                      ],
                    ),
                  ),
                ),
                divider(constraints),
                SizedBox(
                  height: constraints.maxHeight * 0.13,
                  child: ListTile(
                    leading: Container(
                      height: constraints.maxHeight * 0.07,
                      width: constraints.maxWidth * 0.13,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          )),
                    ),
                    title: Text(
                      'Click to view the full image',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 13,
                      ),
                    ),
                    trailing: IconButton(
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.centerRight,
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                        size: 18,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                divider(constraints),
              ],
            ),
          ),
        )
    );
  }
}
