import 'package:flutter/material.dart';
import 'package:DOSTv/sidebar/sidebar_layout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF161C25),
          primaryColor: Color(0xFF161C25)),
      home: SideBarLayout(),
    );
  }
}
