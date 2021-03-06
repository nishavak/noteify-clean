import 'package:flutter/material.dart';
import 'package:noteify/routes/routes.dart';
import 'package:noteify/services/database.dart';
import 'package:noteify/user/label.dart';

class TrashCard extends StatefulWidget {
  final String id;
  final String title;
  final String content;
  final Function refresh;
  final List<dynamic> labels;

  TrashCard({
    this.refresh,
    this.id = '',
    this.title = 'Title',
    this.content = 'Content',
    this.labels,
  });

  @override
  _TrashCardState createState() => _TrashCardState();
}

class _TrashCardState extends State<TrashCard> {
  Future<void> restore(String id) async {
    return await DatabaseService().noteCollection.document(id).updateData({
      'trash': 0,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(4, 0, 4, 10),
      padding: EdgeInsets.all(0),
      width: double.maxFinite,
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, Routes.note,
              arguments: ['trash', widget.id]);
          widget.refresh();
        },
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
                  style:
                      TextStyle(fontWeight: FontWeight.w800, fontSize: 16.088),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Container(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widget.labels
                                .map((e) => Label(
                                      label: e,
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: MaterialButton(
                            onPressed: () async {
                              print('restore');
                              await restore(widget.id);
                              widget.refresh();
                            },
                            color: Colors.white,
                            child: Icon(
                              Icons.restore_from_trash,
                              color: Colors.black54,
                            ),
                            padding: EdgeInsets.all(6),
                            shape: CircleBorder(),
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
