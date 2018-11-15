import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {

  AdminPage({this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Admin "+username),),



    );
  }
}