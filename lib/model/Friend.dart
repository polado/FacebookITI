import 'package:iti_facebook/model/user.dart';

class Friend extends User {
  factory Friend.fromJson(Map<String, dynamic> json) {
    User user = new User(
        id: json['UserID'],
        phone: int.parse(json['UserPhone']),
        email: json['UserMail'],
        firstName: json['UserFirstName'],
        lastName: json['UserLastName'],
        password: "None",
        address: json['UserAddress'],
        gender: json['UserGender'],
        roleID: json['UserRoleID'],
        profilePic: json['UserProfilePicture']);
    if (json['UserDateOfBirth'] != null)
      user.dateOfBirth = DateTime.parse(json['UserDateOfBirth']);
    else
      user.dateOfBirth = new DateTime.now();
    return user;
  }

  String fullName() {
    return '$firstName $lastName';
  }
}
