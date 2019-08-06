import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iti_facebook/model/Friend.dart';
import 'package:iti_facebook/model/user.dart';

class UserServices {
  String _baseURL = "http://www.iti-facebook.somee.com/";

  Future<List<User>> getUsers() async {
    String url = _baseURL + "api/users";
    try {
      http.Response response = await http.get(url);

      print(response.body);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        Iterable users = jsonResponse;
        Iterable<User> iterable = users.map((user) => User.fromJson(user));
        List<User> usersList = iterable.toList();
        return usersList;
      } else
        throw "Somthing Went Wrong";
    } catch (e) {
      throw e;
    }
  }

  Future<User> getUser(int id) async {
    String url = _baseURL + "users/$id";
    try {
      http.Response response = await http.get(url);

      String s = response.statusCode.toString();
      print("login service " + s);
      print("login service " + response.body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        User user = User.fromJson(jsonResponse);
        return user;
      } else
        throw "User Not Found";
    } catch (e) {
      throw e;
    }
  }

  Future<User> login(User user) async {
    String url = _baseURL + "login";
    try {
      http.Response response = await http.post(url, body: user.loginMap());

      String s = response.statusCode.toString();
      print("login service " + s);
      print("login service " + response.body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        User user = User.fromJson(jsonResponse);
        return user;
      } else
        throw "User Not Found";
    } catch (e) {
      throw e;
    }
  }

  Future<int> signup(User user) async {
    String url = _baseURL + "register";
    try {
      print("register " + user.toString());
      http.Response response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(user.signupMap()));

      String s = response.statusCode.toString();
      print("signup service " + s);
      print("signup service " + response.body);

      if (response.statusCode == 200) {
//        var jsonResponse = jsonDecode(response.body);
        int userID = int.parse(response.body);
        return userID;
      } else
        throw "Signup Error";
    } catch (e) {
      throw e;
    }
  }

  Future<Friend> getFriendData(int id) async {
    String url = _baseURL + "UserData/?id=$id";
    try {
      http.Response response = await http.get(url);

      String s = response.statusCode.toString();
//      print("friend service " + s);
//      print("friend service " + response.body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Friend friend = Friend.fromJson(jsonResponse);
        return friend;
      } else
        throw "Friend Not Found";
    } catch (e) {
      throw e;
    }
  }
}
