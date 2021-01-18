import 'package:bench_test_buddies/screens/app_ui/section_view_tab/Resultscreen/view_solution.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ViewSolution extends StatefulWidget {
  @override
  _ViewSolutionState createState() => _ViewSolutionState();
}

class _ViewSolutionState extends State<ViewSolution>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Text("Score Card",
    style: TextStyle(fontSize: 20),),
    Text("View Solution",
      style: TextStyle(color: Colors.black,
    ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black,
            labelPadding: const EdgeInsets.all(15),
            dragStartBehavior: DragStartBehavior.start,
            indicatorColor: Theme.of(context).primaryColor,
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,
              // not when user swapped
            },
            controller: _controller,
            tabs: list,
          ),
          title: Text('View Results',
            style: TextStyle(
            color: Colors.black,
          ),),
          leading:  IconButton(
            onPressed: (){
              //Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Colors.black,),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Center(
                child: Text(
                  _selectedIndex.toString(),
                  style: TextStyle(fontSize: 40),
                )),
            ViewSolutions(),

          ],
        ),
      ),
    );
  }
}