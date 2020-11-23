import 'package:flutter/material.dart';
import 'package:noteify/loading.dart';
import 'package:noteify/routes/routes.dart';
import 'package:noteify/services/database.dart';
import 'package:noteify/user/app-drawer.dart';
import 'package:noteify/user/trash-note.dart';

class TrashView extends StatefulWidget {
  @override
  _TrashViewState createState() => _TrashViewState();
}

class _TrashViewState extends State<TrashView> {
  Future<void> getTrashNotes() async {
    return await DatabaseService().noteCollection.getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTrashNotes(),
      builder: (context, snapshot) {
        List<TrashCard> tc = List<TrashCard>();
        var q =
            snapshot.data.documents.where((note) => note.data['trash'] == 1);
        if (snapshot.hasData) {
          if (q.isEmpty) {
            return Center(
              child: Text('Bin is empty'),
            );
          } else {
            q.map((note) => tc.add(TrashCard(
                  id: note.data.documentID,
                  title: note.data['title'],
                  content: note.data['content'],
                  labels: note.data['labels'],
                )));

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  "Trash",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.navigate_before,
                    size: 30,
                    color: Colors.black54,
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, Routes.dashboard),
                ),
              ),
              body: Container(
                margin: EdgeInsets.all(0),
                height: double.maxFinite,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(color: Colors.white),
                child: SingleChildScrollView(
                    child: Column(
                  children: tc,
                )),
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 20,
                shape: const CircularNotchedRectangle(),
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

              //DRAWER

              drawer: AppDrawer(),
            );
          }
        } else {
          return Loading();
        }
      },
    );
  }
}
