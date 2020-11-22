import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteify/user/dashboard-note.dart';
import 'package:provider/provider.dart';

class DashboardNotesList extends StatefulWidget {
  @override
  _DashboardNotesListState createState() => _DashboardNotesListState();
}

class _DashboardNotesListState extends State<DashboardNotesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          DashboardNote(),
          DashboardNote(),
          DashboardNote(),
          DashboardNote(),
          DashboardNote(),
        ],
      ),
    );
  }
}
