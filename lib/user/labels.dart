import 'package:flutter/material.dart';
import 'package:noteify/loading.dart';
import 'package:noteify/services/database.dart';

class Labels extends StatefulWidget {
  final Function refresh;
  Labels({this.refresh});
  @override
  _LabelsState createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  @override
  Widget build(BuildContext context) {
    Future<void> getNotes() async {
      return await DatabaseService().labelCollection.getDocuments();
    }

    return FutureBuilder(
      future: getNotes(),
      builder: (context, snapshot) {
        List<SimpleDialogOption> children = List<SimpleDialogOption>();
        if (snapshot.hasData) {
          // if (snapshot.data.documents.isEmpty) {}
          snapshot.data.documents.forEach((label) => {
                children.add(SimpleDialogOption(
                  onPressed: () {
                    widget.refresh(label.data['name']);
                    Navigator.pop(context);
                  },
                  child: Text(label.data['name']),
                )),
              });
        } else {
          return Loading();
        }

        return SimpleDialog(
          title: Center(
            child: Column(children: [
              Text('Filter Label',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              RaisedButton.icon(
                  elevation: 1,
                  onPressed: () {
                    widget.refresh('');
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.clear,
                    size: 20,
                  ),
                  label: Text(
                    'Clear',
                    style: TextStyle(fontSize: 16),
                  )),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
          children: children,
        );
      },
    );
  }
}
