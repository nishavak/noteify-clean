import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noteify/services/authentication.dart';
import 'package:noteify/services/database.dart';
import 'package:noteify/user/app-drawer.dart';
import 'package:noteify/user/dashboard-notes-list.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthenticationService _auth = AuthenticationService();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().notes,
      child: Scaffold(
        key: _drawerKey,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'NOTEIFY',
            style: TextStyle(
                color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.w900),
          ),
        ),
        body: Container(
          color: Colors.white,
          height: double.infinity,
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
                          }),
                    ),
                  ],
                ),
              ),
              // ! Notes section
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: double.maxFinite,
                height: 530,
                // color: Colors.grey[100],
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [Colors.grey[100], Colors.white])),
                padding: EdgeInsets.all(10.0),
                child: DashboardNotesList(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('add note');
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
      ),
    );
  }
}
