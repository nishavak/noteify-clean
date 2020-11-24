import 'package:flutter/material.dart';
import 'package:noteify/user/label.dart';

class NoteViewLabels extends StatefulWidget {
  final List<String> labels;
  NoteViewLabels({Key key, this.labels}) : super(key: noteViewLabelsKey);
  @override
  _NoteViewLabelsState createState() => _NoteViewLabelsState();
}

GlobalKey<_NoteViewLabelsState> noteViewLabelsKey = GlobalKey();

class _NoteViewLabelsState extends State<NoteViewLabels> {
  Function labelListRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.labels
          .map((e) => Label(
                label: e,
              ))
          .toList(),
    );
  }
}
