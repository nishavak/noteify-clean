import 'package:flutter/material.dart';
import 'package:noteify/user/label.dart';

class DashboardNote extends StatefulWidget {
  @override
  _DashboardNoteState createState() => _DashboardNoteState();
}

class _DashboardNoteState extends State<DashboardNote> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                'Home Card Header',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16.088),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              Container(
                // constraints: BoxConstraints(minHeight: 80),
                margin: EdgeInsets.only(top: 11, bottom: 13),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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
