import 'package:flutter/material.dart';
import 'package:noteify/user/label.dart';
import 'package:noteify/user/labels.dart';

class NoteView extends StatefulWidget {
  final Object arguments;
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
            ]),
          );
        });
  }

  Future _showLabelModal() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Labels();
        });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.arguments);
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              // color: Colors.grey,
              onPressed: null,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Expanded(
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextField(
                  textAlignVertical: TextAlignVertical.center,
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.symmetric(vertical: 0),
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
                  // indent: 20,
                  endIndent: 0,
                ),
                TextField(
                  textAlignVertical: TextAlignVertical.center,
                  minLines: 2,
                  maxLines: 500,
                  // maxLines: ,
                  keyboardType: TextInputType.visiblePassword,
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
                      children: [
                        Label(),
                      ],
                    ),
                  ),
                )
              ],
            )),
      )),
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        shape: const CircularNotchedRectangle(),
        color: Color(0xffC7FFEC),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                margin: EdgeInsets.only(left: 50),
                padding: EdgeInsets.symmetric(vertical: 11),
                child: Column(
                  children: [
                    Text(
                      'Created on',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('09/10/2020,10:30 am'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
