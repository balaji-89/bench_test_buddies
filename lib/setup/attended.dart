import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../setup/expertise.dart';
import 'package:roundcheckbox/roundcheckbox.dart';


class Attended extends StatelessWidget {

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
                    color: Colors.grey,
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
              backgroundColor: Colors.greenAccent,
              radius: 25,
              child: Center(
                child: SvgPicture.asset("assets/portfolio.svg")
              ),
            ),
            title:Text("Have you attended a professional \nbench test course?"),

          ),
          ListTile(
            trailing:RoundCheckBox(
              isChecked: false,
              checkedColor: Colors.green,
              onTap: (selected) {},
              size: 25,),
            leading:Text("Yes, I have taken bench test course"),
          ),
          Divider(thickness: 1,height: 1,endIndent: 20.0,indent: 20.0,),
          ListTile(
            trailing:RoundCheckBox(
              isChecked: false,
              checkedColor: Colors.green,
              onTap: (selected) {},
              size: 25,),
            leading:Text("No, I haven't taken bench test course"),
          ),
          SizedBox(height: heights.size.height*0.01,),
          LayoutBuilder(
            builder: (ctx,con){
              return InkWell(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=>Expertise())),
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
