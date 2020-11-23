import 'package:flutter/material.dart';
import 'package:noteify/routes/routes.dart';
import 'package:noteify/user/dashboard.dart';
import 'package:noteify/user/manage-labels.dart';
import 'package:noteify/user/note-view.dart';
import 'package:noteify/user/trash.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.dashboard:
        return MaterialPageRoute(builder: (context) => Dashboard());

      case Routes.note:
        return MaterialPageRoute(
            builder: (context) => NoteView(arguments: settings.arguments));

      case Routes.trash:
        return MaterialPageRoute(builder: (context) => TrashView());

      case Routes.manage_labels:
        return MaterialPageRoute(builder: (context) => ManageLabels());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
