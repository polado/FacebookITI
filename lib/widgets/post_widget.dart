import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iti_facebook/model/Friend.dart';
import 'package:iti_facebook/services/user_services.dart';

class PostCardWidget extends StatelessWidget {
  final int userID;
  final String image, content;
  final DateTime datePosted;
  Friend postOwner;

  String img, name;

  PostCardWidget(
      {this.image, this.userID, this.content, this.datePosted, this.postOwner});

  void ownerImage() {
    img = postOwner == null ? image : postOwner.profilePic;
    print('img $img');
  }

  void ownerName() {
    name = postOwner == null ? userID.toString() : postOwner.fullName();
    print('name $name');
  }

  void getOwnerData() {
    UserServices().getFriendData(userID).then((snapshot) async {
      postOwner = snapshot;
      img = postOwner.profilePic;
      name = postOwner.fullName();
    }, onError: (error) {
      postOwner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    getOwnerData();
    ownerImage();
    ownerName();

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.memory(
                  Base64Decoder().convert(img),
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                ),
                Padding(padding: EdgeInsets.only(right: 12)),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: new Divider(
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(content),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: new Divider(
                color: Colors.grey,
              ),
            ),
            Text(
//              DateFormat('yyyy-MM-dd – hh:mm aa').format(datePosted),
              DateFormat('yyyy-MM-dd').format(datePosted),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
