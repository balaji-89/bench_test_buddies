import 'dart:ui';

import 'package:bench_test_buddies/screens/app_ui/attempt_tab/attempted_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttemptCard extends StatelessWidget {
  final int attemptedId;
  final Map scoreCard;
  final String attemptedDate;

  AttemptCard(
      {@required this.attemptedId,
       this.scoreCard,
       this.attemptedDate});


  @override
  Widget build(BuildContext context) {
    final changedDateFormat = attemptedDate == null
        ? null
        : attemptedDate;
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
                  child: Image.asset('assets/attempt_images/target.png',
                      fit: BoxFit.contain),
                ),
                title: Text('Attempt: ${attemptedId.toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                subtitle: SizedBox(
                  width: constraints.maxWidth * 0.8,
                  child: RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                        text: scoreCard == null
                            ? ''
                            : 'Score: ${scoreCard['userScore']}/${scoreCard['totalScore']} | ',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                          text: changedDateFormat == null
                              ? ''
                              : 'Attempted on: $changedDateFormat',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          )),
                    ],
                  )),
                ),
                trailing: IconButton(
                  alignment: Alignment.topCenter,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 16,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AttemptedDetails(
                              attemptId: attemptedId,
                            )));
                  },
                ),
              )),
    );
  }
}
