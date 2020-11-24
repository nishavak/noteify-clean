import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noteify/loading.dart';
import 'package:noteify/models/user.dart';
import 'package:noteify/services/database.dart';
import 'package:noteify/user/label.dart';
import 'package:noteify/user/labels.dart';
import 'package:provider/provider.dart';

class NoteView extends StatefulWidget {
  final List arguments;
  List<String> labels = [];
  NoteView({this.arguments});
  @override
  _NoteViewState createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  void _showOptions(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(children: [
              ListTile(
                title: Text('Add Image'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Add Audio'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Add Label'),
                onTap: () {
                  Navigator.pop(context);
                  _showLabelModal();
                },
              ),
              ListTile(
                title: Text('Remove Label'),
                onTap: () {
                  Navigator.pop(context);
                  print('remove label');
                },
              ),
            ]),
          );
        });
  }

  void refresh(String label) {
    // widget.labels = List<String>.from(widget.labels);
    widget.labels.add(label);
  }

  Future _showLabelModal() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Labels(
            refresh: refresh,
          );
        });
  }

  String title = '';
  String content = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final uid = user.uid;
    Future<void> newNote(String title, String content) async {
      return await DatabaseService().noteCollection.add({
        'title': title,
        'content': content,
        'author': uid,
        'trash': 0,
        'timestamp': Timestamp.now(),
        'labels': widget.labels,
      });
    }

    Future<void> deleteNote() async {
      return await DatabaseService()
          .noteCollection
          .document(widget.arguments[1])
          .updateData({
        'trash': 1,
      });
    }

    Future<void> permanentlyDelete() async {
      return await DatabaseService()
          .noteCollection
          .document(widget.arguments[1])
          .delete();
    }

    Future<void> getNote(String id) async {
      return await DatabaseService().noteCollection.document(id).get();
    }

    Future<void> editNote(String title, String content) async {
      return await DatabaseService()
          .noteCollection
          .document(widget.arguments[1])
          .updateData(
              {'title': title, 'content': content, 'labels': widget.labels});
    }

    Future<void> restoreNote() async {
      return await DatabaseService()
          .noteCollection
          .document(widget.arguments[1])
          .updateData({
        'trash': 0,
      });
    }

    if (widget.arguments[0] == 'new') {
      // ! NEW
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.navigate_before,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: double.maxFinite,
          child: SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      TextField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 21),
                      ),
                      const Divider(
                        color: Colors.black45,
                        height: 5,
                        thickness: 0.2,
                        endIndent: 0,
                      ),
                      TextField(
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {
                          setState(() {
                            content = value;
                          });
                        },
                        textAlignVertical: TextAlignVertical.center,
                        minLines: 2,
                        maxLines: 500,
                        decoration: InputDecoration(
                          hintText: "Content",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: 15),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: double.maxFinite,
                          child: Row(
                            children: widget.labels
                                .map((e) => Label(
                                      label: e,
                                    ))
                                .toList(),
                          ),
                        ),
                      )
                    ],
                  ))),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      _showOptions(context);
                    }),
                IconButton(
                  icon: Icon(
                    Icons.save,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    print('create note');
                    newNote(title, content);
                    Fluttertoast.showToast(
                        msg: 'Note created',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.indigo,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      );
    } else if (widget.arguments[0] == 'dashboard') {
      // ! DASHBOARD
      return FutureBuilder(
          future: getNote(widget.arguments[1]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              title = snapshot.data['title'];
              content = snapshot.data['content'];
              widget.labels = List<String>.from(snapshot.data['labels']);
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.navigate_before,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[50],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          deleteNote();
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: 'Note deleted',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.indigo,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                      ),
                    ),
                  ],
                ),
                body: Container(
                  color: Colors.white,
                  height: double.maxFinite,
                  child: SingleChildScrollView(
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              TextFormField(
                                onChanged: (value) {
                                  title = value;
                                },
                                initialValue: title,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                textAlignVertical: TextAlignVertical.center,
                                minLines: 1,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: "Title",
                                  hintStyle: TextStyle(color: Colors.black26),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(fontSize: 21),
                              ),
                              const Divider(
                                color: Colors.black45,
                                height: 5,
                                thickness: 0.2,
                                endIndent: 0,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  content = value;
                                },
                                initialValue: content,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                readOnly: widget.arguments[0] == 'trash',
                                textAlignVertical: TextAlignVertical.center,
                                minLines: 2,
                                maxLines: 500,
                                decoration: InputDecoration(
                                  hintText: "Content",
                                  hintStyle: TextStyle(color: Colors.black26),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(fontSize: 15),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  width: double.maxFinite,
                                  child: Row(
                                    children: widget.labels
                                        .map((e) => Label(
                                              label: e,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              )
                            ],
                          ))),
                ),
                bottomNavigationBar: BottomAppBar(
                  shape: const CircularNotchedRectangle(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black54,
                            ),
                            onPressed: () {
                              _showOptions(context);
                            }),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 11),
                          child: Column(
                            children: [
                              Text(
                                'Created on',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  '${DateTime.fromMillisecondsSinceEpoch(snapshot.data['timestamp'].seconds * 1000)}'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.save,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            editNote(title, content);
                            // Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: 'Note updated',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.indigo,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Loading();
            }
          });
    } else if (widget.arguments[0] == 'trash') {
      // ! TRASH
      return FutureBuilder(
          future: getNote(widget.arguments[1]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              title = snapshot.data['title'];
              content = snapshot.data['content'];
              widget.labels = List<String>.from(snapshot.data['labels']);
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.navigate_before,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[50],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.restore_from_trash,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          restoreNote();
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: 'Note restored',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.indigo,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                      ),
                    ),
                  ],
                ),
                body: Container(
                  color: Colors.white,
                  height: double.maxFinite,
                  child: SingleChildScrollView(
                      child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              TextFormField(
                                onChanged: (value) {
                                  title = value;
                                },
                                initialValue: title,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                readOnly: widget.arguments[0] == 'trash',
                                textAlignVertical: TextAlignVertical.center,
                                minLines: 1,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: "Title",
                                  hintStyle: TextStyle(color: Colors.black26),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(fontSize: 21),
                              ),
                              const Divider(
                                color: Colors.black45,
                                height: 5,
                                thickness: 0.2,
                                endIndent: 0,
                              ),
                              TextFormField(
                                onChanged: (value) {
                                  content = value;
                                },
                                initialValue: content,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                readOnly: widget.arguments[0] == 'trash',
                                textAlignVertical: TextAlignVertical.center,
                                minLines: 2,
                                maxLines: 500,
                                decoration: InputDecoration(
                                  hintText: "Note",
                                  hintStyle: TextStyle(color: Colors.black26),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(fontSize: 15),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  width: double.maxFinite,
                                  child: Row(
                                    children: widget.labels
                                        .map((e) => Label(
                                              label: e,
                                            ))
                                        .toList(),
                                  ),
                                ),
                              )
                            ],
                          ))),
                ),
                bottomNavigationBar: BottomAppBar(
                  shape: const CircularNotchedRectangle(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 11),
                          child: Column(
                            children: [
                              Text(
                                'Created on',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  '${DateTime.fromMillisecondsSinceEpoch(snapshot.data['timestamp'].seconds * 1000)}'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            permanentlyDelete();
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: 'Note permanently deleted',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.indigo,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Loading();
            }
          });
    }
  }
}
