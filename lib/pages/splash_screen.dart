import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_view.dart';
import 'login.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLoggedIn();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 10);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>
            isLoggedIn ? HomeView() : LoginView()));
  }

  @override
  Widget build(BuildContext context) {
//    return new SplashScreen(
////        seconds: 15,
////        navigateAfterSeconds: after(),
////        title: new Text(
////          'Welcome In SplashScreen',
////          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
////        ),
////        image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
////        backgroundColor: Colors.white,
////        styleTextUnderTheLoader: new TextStyle(),
////        photoSize: 100.0,
////        onClick: () => print("Flutter Egypt"),
////        loaderColor: Colors.red);
    return new Scaffold(
        body: new Scaffold(
            body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Splash Screen"),
          Padding(padding: EdgeInsets.only(top: 20)),
          CircularProgressIndicator(
            backgroundColor: Colors.black,
          ),
        ],
      ),
    )));
  }

  void checkIsLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(sharedPreferences.getString("UserData"));
    (sharedPreferences.getString("UserData") != null)
        ? isLoggedIn = true
        : isLoggedIn = false;
  }

  Widget after() {
    new Timer(new Duration(seconds: 10), null);
    print("is logged in $isLoggedIn");
    return isLoggedIn ? HomeView() : LoginView();
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Welcome In SplashScreen Package"),
          automaticallyImplyLeading: false),
      body: new Center(
        child: new Text(
          "Done!",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }
}
