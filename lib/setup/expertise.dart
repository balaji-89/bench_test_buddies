import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../setup/completion.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class Expertise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heights=MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        //leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: ()=> Navigator.pop(context)),
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: true,
        title: Text("Setup",style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: heights.size.height*0.03,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: heights.size.width*0.30,
                  height: heights.size.height*0.01,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: heights.size.width*0.30,
                  height: heights.size.height*0.01,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: heights.size.width*0.30,
                  height: heights.size.height*0.01,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: heights.size.height*0.03,),
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.yellowAccent,
              child: Center(
                child: SvgPicture.asset("assets/idea.svg")
              ),
            ),
            title:Text("Enter your expertise level in bench \n preparation"),

          ),
          ListTile(
              trailing:RoundCheckBox(
                onTap: (selected) {},
                size: 25,
                checkedColor: Colors.green,
              ),
            leading:Text(" I've been preparing for bench preparation\n for bench preparation "),
          ),
          Divider(thickness: 1,height: 1,endIndent: 20.0,indent: 20.0,),
          ListTile(
            trailing:RoundCheckBox(
            onTap: (selected) {},
            size: 25,
            checkedColor: Colors.green,),
            leading:Text("I'm familiar with the basics but yet to prepare "),
          ),
          Divider(thickness: 1,height: 1,endIndent: 20.0,indent: 20.0,),
          ListTile(
            trailing:RoundCheckBox(
            isChecked: false,
            checkedColor: Colors.green,
            onTap: (selected) {},
            size: 25,),
            leading:Text("I'm a new to bench preparation "),
          ),
          SizedBox(height: heights.size.height*0.01,),
          LayoutBuilder(
            builder: (ctx,con){
              return InkWell(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=>Completion())) ,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: Container(
                      width:heights.size.width*1 ,
                      height: heights.size.height*0.05,
                      decoration: BoxDecoration(
                        color: Color(0xff4667EE),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Text("Next",
                            style: TextStyle(
                                color: Colors.white,fontSize: 18
                            ),
                          )
                      ),
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
