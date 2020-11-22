import 'package:flutter/material.dart';
import 'package:noteify/loading.dart';
import 'package:noteify/services/database.dart';

class Labels extends StatefulWidget {
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
                  onPressed: () {},
                  child: Text(label.data['name']),
                )),
              });
        } else {
          return Loading();
        }

        return SimpleDialog(
          title: Center(
            child: const Text('Filter Label',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          children: children,
        );
      },
    );
  }
}
