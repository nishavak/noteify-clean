import 'package:flutter/material.dart';
import 'package:noteify/loading.dart';
import 'package:noteify/services/database.dart';
import 'package:noteify/user/dashboard-note.dart';

class DashboardNotesList extends StatefulWidget {
  final bool sort;
  final String label;
  final bool search;
  final String query;
  DashboardNotesList({this.sort, this.label, this.search, this.query});
  @override
  _DashboardNotesListState createState() => _DashboardNotesListState();
}

class _DashboardNotesListState extends State<DashboardNotesList> {
  @override
  Widget build(BuildContext context) {
    String sort = widget.sort ? 'title' : 'timestamp';
    Future<void> getNotes() async {
      if (!widget.search) {
        // ! list all
        return await DatabaseService()
            .noteCollection
            .where('trash', isEqualTo: 0)
            .orderBy(sort)
            .getDocuments();
      } else {
        // ! search by query
        return await DatabaseService()
            .noteCollection
            .where('title', isEqualTo: widget.query)
            .getDocuments();
      }
    }

    return FutureBuilder(
      future: getNotes(),
      builder: (context, snapshot) {
        List<DashboardNote> children = List<DashboardNote>();
        if (snapshot.hasData) {
          if (snapshot.data.documents.isEmpty) {
            return Container(
              child: Center(
                  child: widget.search
                      ? Text(
                          'No notes found',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        )
                      : Text(
                          'No notes added',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        )),
            );
          }
          // print(widget.label);
          snapshot.data.documents.forEach((note) => {
                widget.label != ''
                    ? (note.data['labels'].contains(widget.label)
                        ? children.add(DashboardNote(
                            author: note.data['author'],
                            title: note.data['title'],
                            content: note.data['content'],
                            timestamp: note.data['timestamp'],
                            labels: note.data['labels'],
                          ))
                        : null)
                    : children.add(DashboardNote(
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
