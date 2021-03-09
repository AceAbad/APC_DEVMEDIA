import 'package:dostv_app/pages/Search/search.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 23,
        right: 5,
        child: Container(
          alignment: Alignment(10, -0.1),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            children: [
              Container(
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.search,
                        color: Color(0xFF3EC4B2),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Search()),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
