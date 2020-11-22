import 'package:flutter/material.dart';
import 'package:noteify/services/database.dart';
import 'package:noteify/user/dashboard-note.dart';

class DashboardNotesList extends StatefulWidget {
  @override
  _DashboardNotesListState createState() => _DashboardNotesListState();
}

class _DashboardNotesListState extends State<DashboardNotesList> {
  @override
  Widget build(BuildContext context) {
    Future<void> getNotes() async {
      return await DatabaseService().noteCollection.getDocuments();
    }

    return FutureBuilder(
      future: getNotes(),
      builder: (context, snapshot) {
        List<DashboardNote> children = List<DashboardNote>();
        if (snapshot.hasData) {
          snapshot.data.documents.forEach((note) => {
                children.add(DashboardNote(
                    author: note.data['author'],
                    title: note.data['title'],
                    content: note.data['content'],
                    timestamp: note.data['timestamp']))
              });
        }
        return ListView(
          children: children ?? [],
        );
      },
    );
  }
}
