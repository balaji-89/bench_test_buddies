import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'degree.dart';

class ValueScreen extends StatefulWidget {
  @override
  _ValueScreenState createState() => _ValueScreenState();
}

class _ValueScreenState extends State<ValueScreen> {
  TextEditingController controller = TextEditingController();
  Color buttonColor = Color.fromRGBO(240, 238, 235, 1);

  Color buttonTextColor = Colors.black;
  bool onTap = false;

  void initState() {
    controller = TextEditingController();
    controller.addListener(() {
      if (controller.text.isNotEmpty)
        setState(() {
          buttonColor = Color(0xFF4667EE);
          buttonTextColor = Colors.white;
          onTap = true;
        });
      else {
        setState(() {
          buttonColor = Theme.of(context).accentColor;
          buttonTextColor = Colors.black;
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
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Enter the Value in mm",
                  style: TextStyle(
                    color: Colors.black,
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
                    if (onTap == true)
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Degree()));
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
                          fontWeight: FontWeight.bold,
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
