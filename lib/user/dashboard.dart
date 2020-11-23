import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noteify/routes/routes.dart';
import 'package:noteify/services/authentication.dart';
import 'package:noteify/user/app-drawer.dart';
import 'package:noteify/user/dashboard-notes-list.dart';
import 'package:noteify/user/labels.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthenticationService _auth = AuthenticationService();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  bool _sort = true;
  Function sort() {
    setState(() {
      _sort = !_sort;
    });
    return null;
  }

  Future _showFilterModal() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Labels();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'NOTEIFY',
          style: TextStyle(
              color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w900),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.maxFinite,
        child: Column(
          children: [
            // ! Filter and sort buttons
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: IconButton(
                        color: Colors.grey[50],
                        icon: FaIcon(
                          FontAwesomeIcons.sort,
                          size: 18,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          print('sort');
                          sort();
                        }),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(10.0)),
                    child: IconButton(
                        focusColor: Colors.grey[50],
                        icon: FaIcon(
                          FontAwesomeIcons.filter,
                          size: 18,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          print('filter');
                          _showFilterModal();
                        }),
                  ),
                ],
              ),
            ),
            // ! Notes section
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                width: double.maxFinite,
                // height: 530,
                // color: Colors.grey[100],
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [Colors.grey[100], Colors.white])),
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: DashboardNotesList(sort: _sort),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('add note');
          Navigator.pushNamed(context, Routes.note,
              arguments: ['create a new note']);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[50],
        // elevation: 20.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                print('menu');
                _drawerKey.currentState.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                print('search');
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: AppDrawer(),
    );
  }
}
