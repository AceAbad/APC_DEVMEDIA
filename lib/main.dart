import 'package:custom_splash/custom_splash.dart';
import 'package:dostv_app/sidebar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CustomSplash(
      imagePath: 'assets/images/Splashscreen.png',
      logoSize: 250,
      backGroundColor: Color(0xFF232C3D),
      animationEffect: 'fade-in',
      home: MyApp(),
      duration: 2500,
      type: CustomSplashType.StaticDuration,
    ),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var loading = new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: AfterSplash(),
      image: new Image.asset('assets/loading.gif'),
      backgroundColor: Color(0xFF232C3D),
      photoSize: 80.0,
      useLoader: false,
    );
    return loading;
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF161C25),
          primaryColor: Color(0xFF161C25)),
      home: SideBarLayout(),
    );
  }
}
