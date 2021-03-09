import 'package:dostv_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:dostv_app/json/videoinfo.dart';
import 'package:dostv_app/pages/watchpage/sineseryewatchpage.dart';
import 'package:dostv_app/theme/colors.dart';
import 'package:flutter/material.dart';

class Sinesensya extends StatefulWidget with NavigationStates {
  @override
  _SinesensyaState createState() => _SinesensyaState();
}

class _SinesensyaState extends State<Sinesensya>
    with SingleTickerProviderStateMixin {
  bool _isScrollToTopBtnVisible = false;
  AnimationController _animationController;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      reverseDuration: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.position.pixels >= 600) {
      _animationController.forward();
      setState(() => _isScrollToTopBtnVisible = true);
    } else if (_scrollController.position.pixels < 600) {
      _animationController.reverse();
      setState(() => _isScrollToTopBtnVisible = false);
    }
  }

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
      floatingActionButton: Stack(
        children: <Widget>[
          if (_isScrollToTopBtnVisible) ...[
            ScaleTransition(
              scale: CurvedAnimation(
                  parent: _animationController, curve: Curves.fastOutSlowIn),
              child: FloatingActionButton(
                tooltip: 'Scroll to Top',
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Color(0xFF3EC4B2),
                  size: 35,
                ),
                onPressed: () {
                  _animationController.reverse();
                  _scrollController.animateTo(0,
                      duration: Duration(milliseconds: 680),
                      curve: Curves.fastOutSlowIn);
                },
              ),
            ),
          ]
        ],
      ),
      backgroundColor: Color(0xF181D24),
      body: getBody(),
    );
  }

  Widget getBody() {
    return ListView(
      controller: _scrollController,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                ],
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 30.0,
                color: Color(0xFF3EC4B2),
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      "Sinesensya",
                      style: TextStyle(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "LATEST UPLOAD",
            style: TextStyle(
                color: white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          children: List.generate(sineserye_pop.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SineseryeVideoPage(
                                      title: sineserye_pop[index]['title'],
                                      thumbnail: sineserye_pop[index]
                                          ['thumnail_img'],
                                      videoUrl: sineserye_pop[index]
                                          ['video_url'],
                                    )));
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.dstATop),
                                image: AssetImage(
                                    sineserye_pop[index]['thumnail_img']),
                                fit: BoxFit.cover)),
                        child: new Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: 0, top: 0, bottom: 0, right: 0),
                              child: new Stack(
                                children: <Widget>[
                                  new Positioned(
                                    child: new Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 50,
                                        height: 20,
                                        color: Color(0xFF161A20),
                                        child: Center(
                                          child: Text(
                                            sineserye_pop[index]
                                                ['video_duration'],
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  new Positioned(
                                    child: new Align(
                                      child: Icon(
                                        Icons.play_arrow,
                                        size: 60,
                                        color: Color(0xFF3EC4B2),
                                      ),
                                    ),
                                  ),
                                  new Positioned(
                                    left: 10.0,
                                    bottom: 15.0,
                                    child:
                                        new Text(sineserye_pop[index]['title'],
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.0,
                                              color: Colors.white,
                                            )),
                                  ),
                                  new Positioned(
                                    right: 5.0,
                                    bottom: 13.0,
                                    child: Icon(
                                      Icons.bookmark_outline,
                                      size: 30,
                                      color: Color(0xFF3EC4B2),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "MOST POPULAR",
            style: TextStyle(
                color: white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          children: List.generate(sineserye.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => SineseryeVideoPage(
                                      title: sineserye[index]['title'],
                                      thumbnail: sineserye[index]
                                          ['thumnail_img'],
                                      videoUrl: sineserye[index]['video_url'],
                                    )));
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.dstATop),
                                image: AssetImage(
                                    sineserye[index]['thumnail_img']),
                                fit: BoxFit.cover)),
                        child: new Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                  left: 0, top: 0, bottom: 0, right: 0),
                              child: new Stack(
                                children: <Widget>[
                                  new Positioned(
                                    child: new Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 50,
                                        height: 20,
                                        color: Color(0xFF161A20),
                                        child: Center(
                                          child: Text(
                                            sineserye[index]['video_duration'],
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  new Positioned(
                                    child: new Align(
                                      child: Icon(
                                        Icons.play_arrow,
                                        size: 60,
                                        color: Color(0xFF3EC4B2),
                                      ),
                                    ),
                                  ),
                                  new Positioned(
                                    left: 10.0,
                                    bottom: 15.0,
                                    child: new Text(sineserye[index]['title'],
                                        style: new TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        )),
                                  ),
                                  new Positioned(
                                    right: 5.0,
                                    bottom: 13.0,
                                    child: Icon(
                                      Icons.bookmark_outline,
                                      size: 30,
                                      color: Color(0xFF3EC4B2),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
