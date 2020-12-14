import 'package:flutter/material.dart';

class Completion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heights = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: ()=> Navigator.pop(context)),
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        title: Text(
          "Setup",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: heights.size.height * 0.03,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: heights.size.width * 0.30,
                  height: heights.size.height * 0.01,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: heights.size.width * 0.30,
                  height: heights.size.height * 0.01,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: heights.size.width * 0.30,
                  height: heights.size.height * 0.01,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: heights.size.height * 0.03,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellowAccent,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            title: Text(
                "Hey! You are spne with the initial \n setup.Start Practicing.Best Wishes."),
          ),
          SizedBox(
            height: heights.size.height * 0.01,
          ),
          LayoutBuilder(
            builder: (ctx, con) {
              return InkWell(
                //onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=>Completion())) ,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: Container(
                      width: heights.size.width * 1,
                      height: heights.size.height * 0.05,
                      decoration: BoxDecoration(
                        color: Color(0xff4667EE),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Text(
                        "Continue to home screen",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
