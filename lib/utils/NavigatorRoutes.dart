import 'package:flutter/material.dart';
import 'package:notex/app_screens/AddNoteScreen.dart';
import 'package:notex/app_screens/HomeScreen.dart';

class NavigatorRoutes {
  static toHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  static toAddnotes(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddNoteWrapper()));
  }

}
