import 'package:bench_test_buddies/provider/exercise_provider.dart';
import 'package:bench_test_buddies/provider/users_level.dart';
import'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ExerciseTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<Users>(
      context,
    ).userData;

    final userCurrentExercise = Provider.of<Exercises>(context)
        .findExerciseById(userData.userExerciseId);


    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xFF1a1a4b),
          ),
          centerTitle: true,
          elevation: 1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined,color:Colors.black),
            onPressed: (){},

          ),
          title: Text(
            'Exercise Timer',
            style: TextStyle(fontSize:20,color: Color(0xFF1a1a4b)),
          ),
          backgroundColor: Colors.white,

          actions:[
              Align(
                alignment:Alignment.bottomCenter,
                child: FlatButton(
                  child:Text('Settings',textAlign:TextAlign.end,style:TextStyle(
                    fontSize: 15,
                    color:Theme.of(context).primaryColor,
                  )),
                  onPressed:(){
                  },
                ),
              )
          ]
      ),
      body:SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
               SizedBox(
                 height: MediaQuery.of(context).size.height*0.08,
                 width: MediaQuery.of(context).size.width*0.6,
                 child: Text(userCurrentExercise.name, style: TextStyle(
                   color: Colors.black,
                   fontWeight: FontWeight.bold,
                   fontSize: 17,
                 )),
               ),
              //Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.12),child:
              Divider(

                thickness: 1.5,
                color: Colors.grey,
                indent:MediaQuery.of(context).size.width*0.12 ,
                endIndent: MediaQuery.of(context).size.width*0.12 ,
              ),

               

          ],
        ),
      ),
    );
  }
}
