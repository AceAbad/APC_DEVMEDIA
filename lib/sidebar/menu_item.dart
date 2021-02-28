import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const MenuItem({Key key, this.icon, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            color: Color(0xFF232D3D),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 50,
                  width: 20,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.white),
                )
              ],
            ),
          )),
    );
  }
}
