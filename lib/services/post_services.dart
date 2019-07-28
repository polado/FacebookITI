import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iti_facebook/model/Friend.dart';
import 'package:iti_facebook/model/post.dart';
import 'package:iti_facebook/services/user_services.dart';

class PostServices {
  String _baseURL = "http://www.iti-facebook.somee.com/";

  Future<List<Post>> getAllPosts(int id) async {
    String url = _baseURL + "AllPosts/?id=$id";
    print("id $id");
    try {
      http.Response response = await http.get(url);

      print(response.body);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        Iterable posts = jsonResponse;
        Iterable<Post> iterable = posts.map((post) => getPostData(post));
        List<Post> postsList = iterable.toList();
        return postsList;
      } else
        throw "Somthing Went Wrong";
    } catch (e) {
      throw e;
    }
  }

  Post getPostData(Map<String, dynamic> p) {
    Post post = Post.fromJson(p);
//    post.postOwner = getPostOwnerData(post.userID);
    return post;
  }

  Friend getPostOwnerData(int id) {
    Friend friend;
    UserServices().getFriendData(id).then((snapshot) async {
      friend = snapshot;
    }, onError: (error) {
      friend = null;
    });
    return friend;
  }
}
