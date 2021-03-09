import 'package:dostv_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:dostv_app/json/videoinfo.dart';
import 'package:dostv_app/pages/watchpage/homepage/livestream.dart';
import 'package:dostv_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageA extends StatefulWidget with NavigationStates {
  @override
  _HomepageAState createState() => _HomepageAState();
}

class _HomepageAState extends State<HomepageA>
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
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 0, left: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Center(
                child: new ButtonBar(
                  mainAxisSize: MainAxisSize
                      .min, // this will take space as minimum as posible(to center)
                  children: <Widget>[
                    new Container(
                      height: 40,
                      width: 108,
                      color: Color(0xFF232D3D),
                      child: Center(
                        child: TextButton(
                          child: Text(
                            "Feautured Videos",
                            style: TextStyle(
                                color: white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.HomePageClickedEvent);
                          },
                        ),
                      ),
                    ),
                    new Container(
                      height: 40,
                      width: 108,
                      color: Color(0xFF232D3D),
                      child: Center(
                        child: TextButton(
                          child: Text(
                            "Latest Episodes",
                            style: TextStyle(
                                color: white,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.HomePageBClickedEvent);
                          },
                        ),
                      ),
                    ),
                    new Container(
                      height: 40,
                      width: 108,
                      color: Color(0xFF354257),
                      child: Center(
                        child: TextButton(
                          child: Text(
                            "Livestreams",
                            style: TextStyle(
                                color: Color(0xFF3EC4B2),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w400),
                          ),
                          onPressed: () {
                            BlocProvider.of<NavigationBloc>(context)
                                .add(NavigationEvents.HomePageAClickedEvent);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "CURRENT LIVESTREAM",
            style: TextStyle(
                color: white, fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Column(
          children: List.generate(livestream_pop.length, (index) {
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
                                builder: (_) => LivestreamVideoPage(
                                      title: livestream_pop[index]['title'],
                                      thumbnail: livestream_pop[index]
                                          ['thumnail_img'],
                                      videoUrl: livestream_pop[index]
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
                                    livestream_pop[index]['thumnail_img']),
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
                                            livestream_pop[index]
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
                                        new Text(livestream_pop[index]['title'],
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
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Container(
            height: 30.0,
            color: Color(0xFF3EC4B2),
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Container(
                child: Text(
                  "PAST LIVESTREAM",
                  style: TextStyle(
                      color: white, fontSize: 17, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 18,
        ),
        Column(
          children: List.generate(livestream.length, (index) {
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
                                builder: (_) => LivestreamVideoPage(
                                      title: livestream[index]['title'],
                                      thumbnail: livestream[index]
                                          ['thumnail_img'],
                                      videoUrl: livestream[index]['video_url'],
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
                                    livestream[index]['thumnail_img']),
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
                                            lates[index]['video_duration'],
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
                                    child: new Text(livestream[index]['title'],
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
