import 'dart:ui';

import 'package:flutter/material.dart';

class AttemptCard extends StatelessWidget {

  final int attemptNumber;
  final int scoreCard;
  final DateTime attemptedDate;


   AttemptCard(
      {
        @required this.attemptNumber,
        @required this.scoreCard,
        @required this.attemptedDate});

  @override
  Widget build(BuildContext context) {
    // final List<Map> stages = Provider.of<ExcerciseStages>(context).stages;
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.93,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 13,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: Offset(1, 1),
            blurRadius: 2.0,
            spreadRadius: 0.5,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-0, -0),
            blurRadius: 1.0,
            spreadRadius: 1,
          ),
        ],
      ),
      child: LayoutBuilder(
          builder: (context, constraints) => ListTile(
            leading: SizedBox(
              height: constraints.maxHeight * 0.5,
              width: constraints.maxWidth * 0.1,
              child: Image.asset('assets/attempt_images/target.png', fit: BoxFit.contain),
            ),
            title: Text('Attempt: ${attemptNumber.toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                )),
            subtitle: SizedBox(
              width: constraints.maxWidth * 0.8,
              child: RichText(text: TextSpan(
                children: [
                  TextSpan(
                      text:'Score: $scoreCard  |',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,

                    ),),
                  TextSpan(
                    text:'Attempted on: $attemptedDate',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,

                    )
                  ),
                ],
              )),
            ),
            trailing:  Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 15,
            ),
          )),
    );
  }
}
