import 'package:flutter/material.dart';
import 'package:noteify/loading.dart';
import 'package:noteify/services/database.dart';
import 'package:noteify/user/dashboard-note.dart';

class DashboardNotesList extends StatefulWidget {
  final bool sort;
  DashboardNotesList({this.sort});
  @override
  _DashboardNotesListState createState() => _DashboardNotesListState();
}

class _DashboardNotesListState extends State<DashboardNotesList> {
  @override
  Widget build(BuildContext context) {
    String sort = widget.sort ? 'title' : 'timestamp';
    Future<void> getNotes() async {
      return await DatabaseService()
          .noteCollection
          .orderBy(sort)
          .getDocuments();
    }

    return FutureBuilder(
      future: getNotes(),
      builder: (context, snapshot) {
        List<DashboardNote> children = List<DashboardNote>();
        if (snapshot.hasData) {
          if (snapshot.data.documents.isEmpty) {
            return Container(
              child: Center(
                  child: Text(
                'No notes added',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              )),
            );
          }
          snapshot.data.documents.forEach((note) => {
                children.add(DashboardNote(
                  author: note.data['author'],
                  title: note.data['title'],
                  content: note.data['content'],
                  timestamp: note.data['timestamp'],
                  labels: note.data['labels'],
                )),
              });
        } else {
          print('loading');
          return Loading();
        }

        return ListView(
          children: children ?? [],
        );
      },
    );
  }
}
