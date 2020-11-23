import 'package:flutter/material.dart';
import 'package:noteify/routes/routes.dart';
import 'package:noteify/services/authentication.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(30.0),
        children: [
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Navigator.popAndPushNamed(context, Routes.dashboard);
            },
          ),
          ListTile(
            title: Text('Trash'),
            onTap: () {
              Navigator.popAndPushNamed(context, Routes.trash);
            },
          ),
          ListTile(
            title: Text('Manage labels'),
            onTap: () {
              Navigator.popAndPushNamed(context, Routes.manage_labels);
            },
          ),
          ListTile(
            onTap: () async {
              return await _auth.signOut();
            },
            title: Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
