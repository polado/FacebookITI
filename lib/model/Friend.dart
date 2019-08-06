import 'package:iti_facebook/model/user.dart';

class Friend extends User {
  Friend({id,
    phone,
    email,
    firstName,
    lastName,
    password,
    address,
    gender = "M",
    roleID = 2,
    profilePic = "QEA=",
    dateOfBirth});

  factory Friend.fromJson(Map<String, dynamic> json) {
    User user = new Friend(
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

  factory Friend.fromSharedPreferences(Map<String, dynamic> json) {
    print("fromSharedPreferences " + json['UserFirstName']);
    Friend postOwner = new Friend(
        id: int.parse(json['UserID']),
        phone: int.parse(json['UserPhone']),
        email: json['UserMail'],
        firstName: json['UserFirstName'].toString(),
        lastName: json['UserLastName'].toString(),
        password: "None",
        address: json['UserAddress'],
        gender: json['UserGender'],
        roleID: int.parse(json['UserRoleID']),
        dateOfBirth:
        DateTime.parse(json['UserDateOfBirth']) ?? new DateTime.now(),
        profilePic: json['UserProfilePicture']);
    print(postOwner.phone.toString() + " namessssss " + postOwner.fullName());
    return postOwner;
  }

  Map friendMap() {
    var map = new Map<String, dynamic>();
    map["UserID"] = id.toString();
    map["UserFirstName"] = firstName;
    map["UserLastName"] = lastName;
    map["UserMail"] = email;
    map["UserPassword"] = "None";
    map["UserAddress"] = address;
    map["UserPhone"] = phone.toString();
    map["UserDateOfBirth"] = dateOfBirth.toString();
    map["UserRoleID"] = roleID.toString();
    map["UserGender"] = gender;
    map["UserProfilePicture"] = profilePic;
    return map;
  }

  String fullName() {
    return '$firstName $lastName';
  }
}
