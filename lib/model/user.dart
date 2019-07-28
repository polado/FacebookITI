import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String firstName, lastName, email, password, address;
  int phone, roleID;
  DateTime dateOfBirth;
  String gender, profilePic;

  User(
      {this.id: 1,
      this.phone,
      this.email,
      this.firstName,
      this.lastName,
      this.password,
      this.address,
      this.gender = "M",
      this.roleID = 2,
      this.profilePic = "QEA=",
      this.dateOfBirth});

  factory User.fromJson(Map<String, dynamic> json) {
    User user = new User(
        id: json['UserID'],
        phone: int.parse(json['UserPhone']),
        email: json['UserMail'],
        firstName: json['UserFirstName'],
        lastName: json['UserLastName'],
        password: json['UserPassword'],
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

  Map loginMap() {
    var map = new Map<String, dynamic>();
    map["Mail"] = email;
    map["Password"] = password;
    return map;
  }

  Map signupMap() {
    var map = new Map<String, dynamic>();
    map["UserID"] = id.toString();
    map["UserFirstName"] = firstName;
    map["UserLastName"] = lastName;
    map["UserMail"] = email;
    map["UserPassword"] = password;
    map["UserAddress"] = address;
    map["UserPhone"] = phone.toString();
    map["UserDateOfBirth"] = dateOfBirth.toString();
    map["UserRoleID"] = roleID.toString();
    map["UserGender"] = gender;
    map["UserProfilePicture"] = profilePic;
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "id $id,"
        "First Name: $firstName, "
        "Last Name: $lastName,"
        "Email: $email,"
        "\n";
  }
}
