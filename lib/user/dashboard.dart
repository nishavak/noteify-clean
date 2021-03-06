import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noteify/models/user.dart';
import 'package:noteify/routes/routes.dart';
import 'package:noteify/services/authentication.dart';
import 'package:noteify/services/database.dart';
import 'package:noteify/user/app-drawer.dart';
import 'package:noteify/user/dashboard-notes-list.dart';
import 'package:noteify/user/labels.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  String label = '';
  bool _sort = true;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthenticationService _auth = AuthenticationService();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  GlobalKey<ScaffoldState> _searchKey = GlobalKey();

  Function sort() {
    setState(() {
      widget._sort = !widget._sort;
    });
    return null;
  }

  Future _showFilterModal() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Labels(refresh: refresh);
        });
  }

  bool _searchBar = false;
  String query = '';
  // String label = '';

  Function pageRefresh() {
    setState(() {});
  }

  Function refresh(String label, String action) {
    setState(() {
      widget.label = label;
    });
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: 'Sorted by ${widget._sort ? 'Title' : 'Recent'}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.indigo,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    // print(user.uid);
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
            _searchBar
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Form(
                      key: _searchKey,
                      child: TextField(
                          onChanged: (val) {
                            setState(() {
                              query = val;
                            });
                          },
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey[700],
                              decoration: TextDecoration.none),
                          autofocus: true,
                          decoration: InputDecoration(
                              prefixIcon: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.black45,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _searchBar = !_searchBar;
                                  });
                                },
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: EdgeInsets.all(15),
                              border: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.black45,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.grey[800]))),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: widget._sort
                                  ? Colors.grey[50]
                                  : Colors.indigo[50],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: IconButton(
                              color: Colors.grey[50],
                              icon: FaIcon(
                                FontAwesomeIcons.sort,
                                size: 18,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                // showToast();
                                Fluttertoast.showToast(
                                    msg:
                                        'Sorted by ${widget._sort ? 'Recents' : 'Title'}',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.indigo,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                print('sort');
                                sort();
                              }),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: IconButton(
                              color: Colors.grey[50],
                              icon: FaIcon(
                                FontAwesomeIcons.sync,
                                size: 18,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                // showToast();
                                setState(() {});
                                Fluttertoast.showToast(
                                    msg: 'Refreshing',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.indigo,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                print('refresh');
                              }),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: widget.label == ''
                                  ? Colors.grey[50]
                                  : Colors.indigo[50],
                              // color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: IconButton(
                              color: Colors.grey[50],
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
                child: _searchBar
                    ? DashboardNotesList(
                        pageRefresh: pageRefresh,
                        sort: widget._sort,
                        label: widget.label,
                        search: true,
                        query: query)
                    : DashboardNotesList(
                        pageRefresh: pageRefresh,
                        sort: widget._sort,
                        label: widget.label,
                        search: false,
                        query: ''),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('add note');
          await Navigator.pushNamed(context, Routes.note,
              arguments: ['new', '']);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        // color: Colors.grey[50],
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
                setState(() {
                  _searchBar = !_searchBar;
                });
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
