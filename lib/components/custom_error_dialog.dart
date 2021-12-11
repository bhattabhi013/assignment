import 'package:whatsub/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

showCustomErrorDialog(BuildContext context, String title, String content) {
  // set up the button
  Widget okButton = NeumorphicButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: NeumorphicStyle(
          intensity: .4,
          color: Colors.grey[900],
          depth: 10,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(200))),
      padding: EdgeInsets.all(2.0),
      child: Neumorphic(
          style: NeumorphicStyle(
              intensity: .4,
              color: Colors.deepOrange.shade300,
              depth: -10,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(200))),
          child: Center(
            child: Text(
              'OK',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )));

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.backGroundGrey,
    title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
    content: Text(content, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
    actions: [
      SizedBox(width: 32.0 * 2, height: 32.0, child: okButton),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
