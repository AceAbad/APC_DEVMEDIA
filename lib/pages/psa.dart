import 'package:DOSTv/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';

class PSA extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: FractionalOffset(0.6, 0.3),
          width: 300,
          height: 100,
          child: Image(
            width: 120,
            height: 120,
            image: AssetImage('assets/images/LOGO4.png'),
          ),
        ),
      ),
      body: Center(
        child: Text(
          "Public Service Announcement",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 28, color: Colors.white),
        ),
      ),
    );
  }
}
