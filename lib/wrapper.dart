import 'package:flutter/material.dart';
import 'package:noteify/authentication/authenticate.dart';
import 'package:noteify/loading.dart';
import 'package:noteify/models/user.dart';
import 'package:noteify/user/dashboard.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Dashboard();
      // return Loading();
    }
  }
}
