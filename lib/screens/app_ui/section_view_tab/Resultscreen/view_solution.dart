import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ViewSolutions extends StatefulWidget {
  @override
  _ViewSolutionsState createState() => _ViewSolutionsState();
}

class _ViewSolutionsState extends State<ViewSolutions> {
  List<String>   total=["2", "8", "11", "12", "14", "16","1", "3", "4", "5", "6", "7", "9", "10", "13", "15"];
  bool checkedValue = false;
  List<String> incorrect = ["2", "8", "11", "12", "14", "16"];
  List<String> correct = ["1", "3", "4", "5", "6", "7", "9", "10", "13", "15"];
  final Map<String, bool> checkBoxItems = {
    'All': false,
    'Correct': false,
    'Incorrect': false,
    'Book':false,
  };
  List<String> checkBoxKeys;
  int checkedIndex=0;

  @override
  void initState() {

     checkBoxKeys = checkBoxItems.keys.toList();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;


    Widget divider() {
      return Container(
        height: mediaQuery.height * 0.01,
        width: mediaQuery.width,
        color: Theme.of(context).accentColor,
      );
    }

    Widget getCheckBox(index) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.015,
        width: MediaQuery.of(context).size.width * 0.26,
        child: Row(
          children: [
            Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: checkBoxItems[checkBoxKeys[index]],
                onChanged: (bool changed) {
                  checkedIndex=index;
                  changeCheckBoxState(checkBoxKeys[index], changed);
                }),
            Expanded(
              child:checkBoxKeys[index] =='Incorrect'?FittedBox(
                child: Text(
                  checkBoxKeys[index],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ):Text(
                checkBoxKeys[index],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: mediaQuery.height * 0.1,
          width: mediaQuery.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            itemCount: checkBoxItems.length,
            itemBuilder: (context, index) {
              return getCheckBox(index);
            },
          ),
        ),
        divider(),
        GridView.builder(
          shrinkWrap: true,
          itemCount:checkedIndex==0?total.length:checkedIndex==1?correct.length:incorrect.length,
          padding: const EdgeInsets.all(17),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, mainAxisSpacing: 20, crossAxisSpacing: 40),
          itemBuilder: (ctx, i) {
            return Container(
              decoration: BoxDecoration(
                border: checkedIndex==0?Border.all(color: Colors.green):checkedIndex==1?Border.all(color: Colors.green):Border.all(color: Colors.red),
              ),
              child: Center(
                  child: Text(
                    checkedIndex==0?total[i]:checkedIndex==1?correct[i]:incorrect[i],
                style: TextStyle(fontSize: 18),
              )),
            );
          },
        ),
      ],
    );
  }
}
