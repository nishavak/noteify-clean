import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String label;
  const Label({Key key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          right: 8,
          left: 0,
        ),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Text(label, style: TextStyle(fontWeight: FontWeight.w400)));
  }
}
