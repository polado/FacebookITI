import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iti_facebook/model/user.dart';
import 'package:iti_facebook/services/user_services.dart';
import 'package:iti_facebook/widgets/appbar_widget.dart';
import 'package:progress_indicator_button/progress_button.dart';

import 'home_view.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  User user;
  String firstName, lastName, email, password, confirmPassword, address;
  int phone;
  DateTime dateOfBirth;
  String gender;

  bool _buttonClicked = false;

  int radioValueGender = 0;

  final format = DateFormat("yyyy-MM-dd");
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    // TODO: implement initState
    super.initState();
    user = new User(id: 1, roleID: 2, gender: "5");
  }

  void navigate() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomeView(user: user)));
  }

  void signupFuture(AnimationController controller) {
    _buttonClicked = true;
    print("signupFuture " + user.gender);
    controller.forward();
    UserServices().signup(user).then((snapshot) async {
      controller.reverse();
      _buttonClicked = false;
      print(snapshot.toString());
      user.id = snapshot;
      navigate();
    }, onError: (error) {
      print(error);
      controller.reverse();
      _buttonClicked = false;
      snackbar(error.toString());
    });
  }

  void submit(AnimationController controller) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      snackbar('Email: ' + user.email + ', password: ' + user.password);
      signupFuture(controller);
    }
  }

  void snackbar(String text) {
    final snackbar = SnackBar(
      content: Text(text),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void onGenderRadioValueChanged(int value) {
    setState(() {
      radioValueGender = value;
      user.gender = (radioValueGender == 0) ? "0" : "1";
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget signupForm = Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'First Name'),
                    validator: (String value) {
                      if (value.isEmpty)
                        return "Please Enter Your First Name";
                      else if (value.length < 3)
                        return "First Name At Least 3 Charachers";
                      return null;
                    },
                    onSaved: (String value) {
                      setState(() {
                        user.firstName = value;
                      });
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Last Name'),
                    validator: (String value) {
                      if (value.isEmpty)
                        return "Please Enter Your Last Name";
                      else if (value.length < 3)
                        return "Last Name At Least 3 Charachers";
                      return null;
                    },
                    onSaved: (String value) {
                      setState(() {
                        user.lastName = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Address'),
              validator: (String value) {
                if (value.isEmpty) return "Please Enter Your Address";
                return null;
              },
              onSaved: (String value) {
                setState(() {
                  user.address = value;
                });
              },
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
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
                  user.email = value;
                });
              },
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Password"),
              validator: (String value) {
                password = value;
                if (value.isEmpty) return "Please Enter Password";
//                else if (!EmailValidator.Validate(value, true))
//                  return "Please Enter Email";
                return null;
              },
              onSaved: (String value) {
                setState(() {
                  user.password = value;
                });
              },
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Confirm Password"),
              validator: (String value) {
                if (value.isEmpty)
                  return "Please Confirm Password";
                else if (password != value) return "Password Must Match";
                return null;
              },
              onSaved: (String value) {
                setState(() {
                  confirmPassword = value;
                });
              },
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextFormField(
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Phone Number"),
              validator: (String value) {
                if (value.isEmpty) return "Please Enter Phone Number";
                return null;
              },
              onSaved: (String value) {
                setState(() {
                  user.phone = int.parse(value);
                });
              },
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
            Column(
              children: <Widget>[
                Text(
                  "Choose Gender",
                  style: TextStyle(fontSize: 18),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Radio(
                        value: 0,
                        groupValue: radioValueGender,
                        onChanged: onGenderRadioValueChanged),
                    Text("Male"),
                    Radio(
                        value: 1,
                        groupValue: radioValueGender,
                        onChanged: onGenderRadioValueChanged),
                    Text("Female"),
                  ],
                ),
              ],
            ),
            DateTimeField(
              format: format,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Date Of Birth"),
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
              onSaved: (DateTime value) {
                user.dateOfBirth = value;
                print("dateOfBirth " + value.toString());
              },
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ProgressButton(
                  borderRadius: BorderRadius.circular(8),
                  child: Text(
                    "Signup",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: (AnimationController controller) {
                    if (!_buttonClicked) submit(controller);
                  }),
            ),
          ],
        ));
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text("Signup"),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: signupForm,
      ),
    );
  }
}
