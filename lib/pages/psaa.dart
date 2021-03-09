import 'package:dostv_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:dostv_app/json/videoinfo.dart';
import 'package:dostv_app/pages/watchpage/interviewswatchpage.dart';
import 'package:dostv_app/pages/watchpage/psawatchpage.dart';
import 'package:dostv_app/theme/colors.dart';
import 'package:flutter/material.dart';

class PSA extends StatefulWidget with NavigationStates {
  @override
  _PSAState createState() => _PSAState();
}

class _PSAState extends State<PSA> with SingleTickerProviderStateMixin {
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
                      "PUBLIC SERVICE ANNOUNCEMENT",
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
          children: List.generate(psa_watch.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PSAVideoPagePage(
                              title: psa_watch[index]['title'],
                              thumbnail: psa_watch[index]['thumnail_img'],
                              videoUrl: psa_watch[index]['video_url'],
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image:
                                  AssetImage(psa_watch[index]['thumnail_img']),
                              fit: BoxFit.cover)),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 10,
                            right: 12,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  bookmarks[index]['video_duration'],
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: white.withOpacity(0.4)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 130) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  psa_watch[index]['title'],
                                  style: TextStyle(
                                      color: white.withOpacity(0.9),
                                      fontWeight: FontWeight.w500,
                                      height: 1.3,
                                      fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
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
                ),
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
          children: List.generate(psa_bottom.length, (index) {
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
                                builder: (_) => PSAVideoPagePage(
                                      title: psa_bottom[index]['title'],
                                      thumbnail: psa_bottom[index]
                                          ['thumnail_img'],
                                      videoUrl: psa_bottom[index]['video_url'],
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
                                    psa_bottom[index]['thumnail_img']),
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
                                            psa_bottom[index]['video_duration'],
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
                                    child: new Text(psa_bottom[index]['title'],
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
