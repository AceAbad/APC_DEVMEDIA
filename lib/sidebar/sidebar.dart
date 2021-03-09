import 'dart:async';
import 'package:dostv_app/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:dostv_app/sidebar/menuitem/menu_item.dart';
import 'package:dostv_app/sidebar/menuitem/menu_itembookmark.dart';
import 'package:dostv_app/sidebar/menuitem/menu_itemhome.dart';
import 'package:dostv_app/sidebar/menuitem/menu_itempsa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class Sidebar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<Sidebar>
    with SingleTickerProviderStateMixin<Sidebar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSidebarOpenedStreamController.stream;
    isSideBarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSideBarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSideBarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 36,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: const Color(0xFF161A20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      ListTile(
                        title: Container(
                          width: 20,
                          height: 40,
                          child: Image(
                            image: AssetImage('assets/images/LOGO4.png'),
                          ),
                        ),
                      ),
                      MenuItemHome(
                        icon: Icons.home,
                        title: "Home",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.HomePageClickedEvent);
                        },
                      ),
                      MenuItem(
                        title: "Sinesensya",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.SinesensyaClickedEvent);
                        },
                      ),
                      MenuItem(
                        title: "Balitang RapiDOST",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.BalitangClickedEvent);
                        },
                      ),
                      MenuItem(
                        title: "Interviews",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.InterviewsClickedEvent);
                        },
                      ),
                      MenuItemPSA(
                        title: "Public Service Announcements",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.PSAClickedEvent);
                        },
                      ),
                      MenuItemBookmark(
                        title: "Bookmarks",
                        onTap: () {
                          onIconPressed();
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.BookmarkClickedEvent);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.90),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: Container(
                    width: 35,
                    height: 50,
                    color: Color(0xFF161A20),
                    alignment: FractionalOffset(0.9, 0.50),
                    child: AnimatedIcon(
                      progress: _animationController.view,
                      icon: AnimatedIcons.menu_close,
                      color: Color(0xFF3EC4B2),
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
