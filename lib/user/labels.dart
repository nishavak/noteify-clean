import 'package:flutter/material.dart';
import 'package:noteify/loading.dart';
import 'package:noteify/models/user.dart';
import 'package:noteify/services/database.dart';
import 'package:provider/provider.dart';

class Labels extends StatefulWidget {
  final Function refresh;
  final String loc;
  final String action;
  Labels({this.refresh, this.loc = 'dashboard', this.action = 'add'});
  @override
  _LabelsState createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final String uid = user.uid;
    Future<void> getNotes() async {
      return await DatabaseService().labelCollection.getDocuments();
    }

    return FutureBuilder(
      future: getNotes(),
      builder: (context, snapshot) {
        List<SimpleDialogOption> children = List<SimpleDialogOption>();
        if (snapshot.hasData) {
          // if (snapshot.data.documents.isEmpty) {}
          snapshot.data.documents
              .where((label) => label['author'] == uid)
              .forEach((label) => {
                    children.add(SimpleDialogOption(
                      onPressed: () {
                        widget.refresh(label.data['name'], widget.action);
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
              Text(
                  widget.loc == 'dashboard'
                      ? 'Filter label'
                      : (widget.action == 'add' ? 'Add label' : 'Remove label'),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              widget.loc == 'dashboard'
                  ? RaisedButton.icon(
                      elevation: 1,
                      color: Colors.indigo,
                      onPressed: () {
                        widget.refresh('', widget.action);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: Text(
                        'Clear',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ))
                  : Container(),
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
