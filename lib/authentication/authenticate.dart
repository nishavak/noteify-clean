import 'package:flutter/material.dart';
import 'package:noteify/authentication/forgot-password.dart';
import 'package:noteify/authentication/login.dart';
import 'package:noteify/authentication/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  String showPage = 'login';
  void toggleView(String page) {
    setState(() {
      showPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showPage == 'login') {
      return Login(toggleView: toggleView);
    } else if (showPage == 'register') {
      return Register(toggleView: toggleView);
    } else if (showPage == 'forgot-password') {
      return ForgotPassword(toggleView: toggleView);
    }
  }
}
