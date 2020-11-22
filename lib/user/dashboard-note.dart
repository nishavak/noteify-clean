import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteify/user/label.dart';

class DashboardNote extends StatefulWidget {
  final String author;
  final String title;
  final String content;
  final Timestamp timestamp;

  DashboardNote({this.author, this.title, this.content, this.timestamp});
  @override
  _DashboardNoteState createState() => _DashboardNoteState();
}

class _DashboardNoteState extends State<DashboardNote> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Card(
        shadowColor: Colors.black26,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 4,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.088),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              Container(
                // constraints: BoxConstraints(minHeight: 80),
                margin: EdgeInsets.only(top: 11, bottom: 13),
                child: Text(
                  widget.content,
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Label(
                      label: 'Label 1',
                    ),
                    Label(
                      label: 'Label 2',
                    ),
                    Label(
                      label: 'Label 3',
                    ),
                    Label(
                      label: 'Label 4',
                    ),
                    Label(
                      label: 'Label 5',
                    ),
                    Label(
                      label: 'Label 6',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
