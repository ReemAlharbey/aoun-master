
import 'package:flutter/material.dart';

// ignore: camel_case_types
class notification extends StatefulWidget {
  notification({Key key}) : super(key: key);

  @override
  State<notification> createState() => _notificationState();
}

// ignore: camel_case_types

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Container(child: Center(child: Text("الاشعارت"),),));
  }
}