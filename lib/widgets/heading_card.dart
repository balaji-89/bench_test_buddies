import 'package:flutter/material.dart';

class HeadingCard extends StatelessWidget {
  final String iconPath;
  final String stageName;
  final bool arrow;

  const HeadingCard(
      {@required this.iconPath, @required this.stageName, this.arrow = false});

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
        boxShadow: arrow==true?[
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
        ]:[],
      ),
      child: LayoutBuilder(
          builder: (context, constraints) => ListTile(
                leading: SizedBox(
                  height: constraints.maxHeight * 0.5,
                  width: constraints.maxWidth * 0.1,
                  child: Image.asset(iconPath, fit: BoxFit.contain),
                ),
                title: Text(stageName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    )),
                trailing: arrow
                    ? Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      )
                    : null,
              )),
    );
  }
}
