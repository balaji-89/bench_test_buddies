import 'package:bench_test_buddies/provider/evaluation_questions_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'evaluation_home.dart';


class Degree extends StatefulWidget {
  @override
  _DegreeState createState() => _DegreeState();
}

class _DegreeState extends State<Degree> {
  TextEditingController controller = TextEditingController();
  Color buttonColor = Color.fromRGBO(240, 238, 235, 1);

  Color buttonTextColor = Color(0xff232323);
  bool onTap = false;

  void initState() {
    controller = TextEditingController();
    controller.addListener(() {
      if (controller.text.isNotEmpty)
        setState(() {
          buttonColor = Color(0xFF4667EE);
          buttonTextColor = Color(0xffffffff);
          onTap = true;
        });
      else {
        setState(() {
          buttonColor = Color.fromRGBO(240, 238, 235, 1);
          buttonTextColor = Color(0xff232323);
          onTap = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Measurement",
            style: TextStyle(fontWeight:FontWeight.w600,fontSize: 18, color: Color(0xff232323)),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xff232323),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Enter the Value in degree",
                  style: TextStyle(
                    color: Color(0xff232323),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: heights.width * 0.92,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: controller,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.number,

                    // keyboardAppearance: TextInputType.number,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: InkWell(
                  onTap: () {
                    if(onTap==true){
                      Provider.of<EvaluationsQuestionsProvider>(context,listen: false).storeUsersAnswers(double.parse(controller.text));
                      Provider.of<EvaluationsQuestionsProvider>(context,listen:false).incrementQuestionIndex();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => EvaluationHome()));}
                  },
                  child: Container(
                    width: heights.width * 0.95,
                    height: heights.height * 0.06,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      //Color(0xffF5F5F5),
                    ),
                    child: Center(
                      child: Text(
                        "Done",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: buttonTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    controller.dispose();
    super.dispose();
  }
}
