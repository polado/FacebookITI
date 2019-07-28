// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      id: json['id'] as int,
      phone: json['phone'] as int,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      password: json['password'] as String,
      address: json['address'] as String,
      gender: json['gender'] as String,
      roleID: json['roleID'] as int,
      profilePic: json['profilePic'] as String,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String));
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'address': instance.address,
      'phone': instance.phone,
      'roleID': instance.roleID,
      'dateOfBirth': instance.dateOfBirth?.toString(),
      'gender': instance.gender,
      'profilePic': instance.profilePic
    };
