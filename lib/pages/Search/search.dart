import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Search() : super();

  final String title = "Search";

  @override
  UserFilterDemoState createState() => UserFilterDemoState();
}

class UserFilterDemoState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(2.0),
              hintStyle: TextStyle(color: Colors.white),
              hintText: '"Search"',
              border: InputBorder.none),
        ),
      ),
      body: Column(
        children: <Widget>[
          Divider(
            height: 1,
            thickness: .5,
            color: Colors.white.withOpacity(0.3),
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }
}
