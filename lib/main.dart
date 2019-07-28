import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iti_facebook/pages/home_view.dart';
import 'package:iti_facebook/pages/login.dart';

import 'model/user.dart';

const SystemUiOverlayStyle lightSystemUiOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.white,
  systemNavigationBarColor: Colors.white,
  systemNavigationBarDividerColor: Colors.black,
  systemNavigationBarIconBrightness: Brightness.dark,
);

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(lightSystemUiOverlayStyle);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textSelectionHandleColor: Colors.black,
        textSelectionColor: Colors.black12,
        cursorColor: Colors.black,
        toggleableActiveColor: Colors.black,
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.1)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
//      home: HomeView(
//        user:
//        new User(id: 1, firstName: 'test', lastName: 'test', email: 'test'),
//      ),
    home: LoginView(),
    );
  }
}
