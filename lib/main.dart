import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteify/models/user.dart';
import 'package:noteify/services/authentication.dart';
import 'package:noteify/wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return StreamProvider<User>.value(
      value: AuthenticationService().user,
      child: MaterialApp(
        title: 'Noteify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          fontFamily: 'Inter',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}
