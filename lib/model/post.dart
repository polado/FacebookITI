import 'package:json_annotation/json_annotation.dart';

import 'Friend.dart';

@JsonSerializable()
class Post {
  int id, userID;
  DateTime datePosted;
  String content;
  bool isDeleted;

  Friend postOwner;

  Post({this.id, this.userID, this.datePosted, this.content, this.isDeleted});

  factory Post.fromJson(Map<String, dynamic> json) {
    Post post = new Post(
        id: json['PostID'],
        userID: json['PostUserID'],
        datePosted: DateTime.parse(json['PostDate']),
        content: json['PostContent'],
        isDeleted: json['PostIsDeleted']);
    return post;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'id: $id,'
        'date posted: $datePosted,'
        'content: $content,'
        '\n';
  }

}
