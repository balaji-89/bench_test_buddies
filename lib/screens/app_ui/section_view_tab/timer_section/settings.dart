import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    bool status = false;
    final heights=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: (){
          Navigator.pop(context);
        },
        ),
        centerTitle: true,
        title: Text("Exercise Timer",style:TextStyle(color: Colors.black,
          fontSize: 20,
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Settings",style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 20,
            ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: heights.width*1,
            color: Colors.white,
            child: ListTile(
              title: Text("Do not disturb"),
              trailing: FlutterSwitch(
    width: 100.0,
    height: 55.0,
    toggleSize: 45.0,
    value: status,
    borderRadius: 30.0,
    padding: 8.0,
    showOnOff: true,
    onToggle: (val) {
    setState(() {
    status = val;
    });
        },
        )
    ),
          ),
          Container(
            width: heights.width*1,
            color: Colors.white,
            child: ListTile(
                title: Text("Do not disturb"),
                trailing: FlutterSwitch(
                  width: 100.0,
                  height: 55.0,
                  toggleSize: 45.0,
                  value: status,
                  borderRadius: 30.0,
                  padding: 8.0,
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      status = val;
                    });
                  },
                )
            ),
          ),

        ],
      ),
    );
  }
}
