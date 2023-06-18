import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  String btn_text;
  Function() callBack;
  CustomTextButton({required this.btn_text,required this.callBack});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(btn_text.toUpperCase(), style: TextStyle(fontSize: 14)),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
            foregroundColor:
                MaterialStateProperty.all<Color>(Colors.deepPurple),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.deepPurple)))),
        onPressed: callBack);
  }
}
