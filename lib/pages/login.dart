import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:iti_facebook/model/user.dart';
import 'package:iti_facebook/services/user_services.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email, password;

  bool _buttonClicked = false;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  User user;

  SharedPreferences sharedPreferences;

  void initState() {
    // TODO: implement initState
    super.initState();
    user = new User();
  }

  void setUserData() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setString(
          "UserData", jsonEncode(user.signupMap()).toString());
      print("login shared pref" + sharedPreferences.getString("UserData"));
    });
  }

  void navigate() {
    setUserData();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomeView()));
  }

  void loginFuture(AnimationController controller) {
    _buttonClicked = true;

    user.email = email;
    user.password = password;

    controller.forward();
    UserServices().login(user).then((snapshot) async {
      controller.reverse();
      _buttonClicked = false;
      user = snapshot;
      print(user.toString());
      navigate();
    }, onError: (error) {
      controller.reverse();
      print(error.toString());
      _buttonClicked = false;
      snackbar(error.toString());
    });
  }

  void submit(AnimationController controller) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      snackbar('Email: $email, password: $password');
      loginFuture(controller);
    }
  }

  void snackbar(String text) {
    final snackbar = SnackBar(
      content: Text(text),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    Widget loginForm = Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Email'),
            validator: (String value) {
              if (value.isEmpty)
                return "Please Enter Email";
              else if (!EmailValidator.Validate(value, true))
                return "Please Enter Email";
              return null;
            },
            onSaved: (String value) {
              setState(() {
                email = value;
              });
            },
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Password"),
            validator: (String value) {
              if (value.isEmpty) return "Please Enter Password";
              return null;
            },
            onSaved: (String value) {
              setState(() {
                password = value;
              });
            },
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            width: MediaQuery.of(context).size.width,
            child: ProgressButton(
                progressIndicatorColor: Colors.black,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: (AnimationController controller) {
                  if (!_buttonClicked) submit(controller);
                }),
          ),
        ],
      ),
    );

    var card = Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: loginForm,
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: loginForm,
      ),
    );
  }
}
