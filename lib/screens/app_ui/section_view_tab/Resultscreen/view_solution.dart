import 'package:bench_test_buddies/provider/view_result_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ViewSolutions extends StatefulWidget {
  @override
  _ViewSolutionsState createState() => _ViewSolutionsState();
}

class _ViewSolutionsState extends State<ViewSolutions> {
  List<String>   total;
  bool checkedValue = false;
  List<String> incorrect;
  List<String> correct;
  final Map<String, bool> checkBoxItems = {
    'All': true,
    'Correct': false,
    'Incorrect': false,
    'Book':false,
  };
  List<String> checkBoxKeys;
  int checkedIndex=0;

  @override
  void initState() {
    total=Provider.of<ViewResultProvider>(context,listen:false).all;
    correct= Provider.of<ViewResultProvider>(context,listen:false).correct;
    incorrect=Provider.of<ViewResultProvider>(context,listen:false).inCorrect;

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
                activeColor: Theme.of(context).primaryColor,
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
