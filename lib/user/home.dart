import 'package:flutter/material.dart';
import 'package:noteify/services/authentication.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationService _auth = AuthenticationService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Noteify'),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () async {
              await _auth.signOut();
            },
            child: Text('Sign out'),
          ),
        ),
      ),
    );
  }
}
