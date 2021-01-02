import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override


  final List<Map<String, dynamic>> _settings = [
    {
      'setting': 'Do Not Disturb',
      'description': 'Do Not Disturb silences calls and notification',
      'status': false,
    },
    {
      'setting': 'Stop Alarm Tone',
      'description': 'Rings for 10 seconds after the timer ends',
      'status': false,
    },
    {
      'setting': 'Vibration',
      'description': 'Vibrates for 10 seconds after the timer ends',
      'status': false,
    },
    {
      'setting': 'Active Timer Screen',
      'description': 'Once you enable this timer screen will be active state',
      'status': false,
    }
  ];

  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("Settings",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            )),
      ),
      body: SizedBox(
        height: mediaQuery.height,
        width: mediaQuery.width,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              top: mediaQuery.height * 0.05,
            ),
            itemCount: _settings.length,
            itemBuilder: (context, index) {
              return Container(
                height: mediaQuery.height * 0.13,
                width: mediaQuery.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                    height: mediaQuery.height * 0.072,
                    color: Theme.of(context).backgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_settings[index]['setting']}',textAlign:TextAlign.center,style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),),
                        Switch(activeColor: Colors.green,value: _settings[index]['status'], onChanged: (value){
                          setState(() {
                            _settings[index]['status']=value;
                          });
                        })
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Theme.of(context).accentColor,
                      padding: EdgeInsets.only(left: 7,top:7),
                      child: Text(
                        '${_settings[index]['description']}',textAlign:TextAlign.left,style: TextStyle(
                        color: Colors.black87,
                        fontSize: 10,
                      ),
                      ),
                    ),
                  ),
                ]),
              );
            }),
      ),
    );
  }
}
