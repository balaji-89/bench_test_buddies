import 'package:flutter/material.dart';
import '../bar.dart';
import 'package:segmented_circle_border/segmented_circle_border.dart';

//View result screen on process

class Result extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Result"),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.backspace,color: Colors.black,),
        ),
        bottom: TabBar(
          controller: TabController(vsync: null, length: 2),
          onTap: (index){},
          tabs: [
            Text("Score Card"),
            Text("View Solutions"),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Finalsc(),
          Text("222222222222"),
        ],
      ),
    );
  }
}



class Finalsc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heights=MediaQuery.of(context).size;
    return Column(
      children: [
        Material(
            shape: SegmentedCircleBorder(
                offset: (320 / 180),
                numberOfSegments: 2,
                sides: <BorderSide>[
                  BorderSide(color: Bar().oran, width: 15.0),
                  BorderSide(color: Bar().gree, width: 15.0),
                ]),
            child: Center(
              child: Container(
                width: heights.width*0.4,
                height: heights.height*0.2,
                child: Column(
                  children: [
                    Text("16",style: TextStyle(fontSize: 55),),
                    Spacer(),
                    Divider(thickness: 6,height: 2,),
                    Spacer(),
                    Text("30",style: TextStyle(fontSize: 55),),
                  ],
                ),
              ),
            )),
        FlutterLogo(),
      ],
    );
  }
}



class SegmentedCircleBorderExample extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
 final heights=MediaQuery.of(context).size;
   return Scaffold(
      appBar: AppBar(),
      body: Material(
      shape: SegmentedCircleBorder(
          offset: (320 / 180),
          numberOfSegments: 2,
          sides: <BorderSide>[
            BorderSide(color: Bar().oran, width: 15.0),
            BorderSide(color: Bar().gree, width: 15.0),
          ]),
      child: Center(
        child: Container(
          width: heights.width*0.4,
          height: heights.height*0.2,
          child: Column(
            children: [
              Text("16",style: TextStyle(fontSize: 55),),
              Spacer(),
              Divider(thickness: 6,height: 2,),
              Spacer(),
              Text("30",style: TextStyle(fontSize: 55),),
            ],
          ),
        ),
      ))
  );}
}