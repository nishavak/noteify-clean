import 'package:flutter/material.dart';
import 'package:noteify/loading.dart';
import 'package:noteify/models/user.dart';
import 'package:noteify/routes/routes.dart';
import 'package:noteify/services/database.dart';
import 'package:noteify/user/app-drawer.dart';
import 'package:noteify/user/label.dart';
import 'package:noteify/user/trash-note.dart';
import 'package:provider/provider.dart';

class TrashView extends StatefulWidget {
  @override
  _TrashViewState createState() => _TrashViewState();
}

class _TrashViewState extends State<TrashView> {
  Future<void> getTrashNotes() async {
    return await DatabaseService()
        .noteCollection
        .orderBy('title')
        .getDocuments();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final uid = user.uid;

    return FutureBuilder(
      future: getTrashNotes(),
      builder: (context, snapshot) {
        // List<TrashCard> tcl = List<TrashCard>();
        if (snapshot.hasData) {
          if (snapshot.data.documents
              .where((note) => note.data['trash'] == 1)
              .isEmpty) {
            // ! TRASH EMPTY
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
                child: Center(
                  // child: Text('Bin is empty'),
                  child: Image.network(
                    'https://24.media.tumblr.com/a266677ebf095387092ed52add0685b8/tumblr_mpaas5eUwa1qh3xpmo1_500.gif',
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                  // child: Image.network(
                  //     'https://24.media.tumblr.com/a266677ebf095387092ed52add0685b8/tumblr_mpaas5eUwa1qh3xpmo1_500.gif'),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 20,
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
            // ! TRASH NOT EMPTY
            // return Text('hey');
            List<TrashCard> trash_cards = List<TrashCard>();
            snapshot.data.documents
                .where(
                    (note) => (note['trash'] == 1) && (note['author'] == uid))
                .forEach((note) {
              trash_cards.add(TrashCard(
                  refresh: refresh,
                  id: note.documentID,
                  title: note['title'],
                  content: note['content'],
                  labels: note['labels']));
            });

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
                    children: trash_cards,
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                elevation: 20,
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
          }
        } else {
          return Loading();
        }
      },
    );
  }
}
