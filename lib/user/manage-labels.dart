import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteify/loading.dart';
import 'package:noteify/routes/routes.dart';
import 'package:noteify/services/database.dart';
import 'package:noteify/user/app-drawer.dart';

class ManageLabels extends StatefulWidget {
  @override
  _ManageLabelsState createState() => _ManageLabelsState();
}

class ManageLabelItem {
  final String id;
  final String name;

  ManageLabelItem({this.id, this.name});
}

class _ManageLabelsState extends State<ManageLabels> {
  GlobalKey<FormState> _createlabel = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Future<void> createLabel(String name) async {
      return await DatabaseService().labelCollection.add({'name': name});
    }

    Future<void> getLabels() async {
      return await DatabaseService()
          .labelCollection
          .orderBy('name')
          .getDocuments();
    }

    // Future<void> getLabels2() async {
    //   QuerySnapshot res =
    //       await DatabaseService().labelCollection.getDocuments();
    //   res.documents
    //       .where((element) => element.data['labels'].contains(widget.label))
    //       .forEach((element) {
    //     print(element);
    //   });
    // }

    Future<void> deleteLabel(String id) async {
      // ! delete from notes first.
      return await DatabaseService().labelCollection.document(id).delete();
    }

    // getLabels2();

    return FutureBuilder(
        future: getLabels(),
        builder: (context, snapshot) {
          List<ManageLabelItem> labels = List<ManageLabelItem>();
          if (snapshot.hasData) {
            // print(snapshot.data.documents[0].id);
            snapshot.data.documents.forEach((label) => {
                  labels.add(ManageLabelItem(
                      id: label.documentID, name: label['name']))
                });
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.navigate_before,
                    size: 30,
                    color: Colors.black54,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.dashboard),
                ),
                title: Text(
                  'Manage Labels',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    // fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              body: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Form(
                        key: _createlabel,
                        child: TextField(
                            onSubmitted: (s) async {
                              await createLabel(s);
                              setState(() {});
                            },
                            textCapitalization: TextCapitalization.sentences,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey[700],
                                decoration: TextDecoration.none),
                            autofocus: false,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Colors.grey[100],
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Create Label',
                                hintStyle: TextStyle(color: Colors.grey[600]))),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          padding: EdgeInsets.only(
                              top: 5, left: 15, right: 15, bottom: 5),
                          itemCount: labels.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: ListTile(
                                  title: Text('${labels[index].name}'),
                                  trailing: IconButton(
                                      onPressed: () {
                                        deleteLabel(labels[index].id);
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.delete,
                                          color: Colors.black54))),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 20,
                shape: CircularNotchedRectangle(),
                // color: Color(0xffC7FFEC),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  height: 60,
                  child: Row(
                    children: [
                      Builder(builder: (BuildContext context) {
                        return IconButton(
                            icon: Icon(
                              Icons.menu,
                              size: 30,
                            ),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            });
                      }),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              drawer: AppDrawer(),
            );
          } else {
            return Loading();
          }
        });
  }
}
