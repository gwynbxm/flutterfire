import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final int id;
  final String username;
  final String emailAddress;
  final String profilePhoto;

  //constructor
  // User({String em, String pwd}) {
  //   emailAdd = em;
  //   password = pwd;
  // }

  //simplified constructor of the constructor above
  UserData({this.id, this.username, this.profilePhoto, this.emailAddress});

  //construct new User instance from map structure
  factory UserData.fromMap(Map<String, dynamic> json) => new UserData(
        id: json["id"],
        username: json["username"],
        emailAddress: json["emailAddress"],
        profilePhoto: json["profilePhoto"],
      );

  //convert object into something that can be stored in a Firestore document
  Map<String, dynamic> toMap() => {
        'username': username,
        'emailAddress': emailAddress,
        'profilePhoto': profilePhoto,
      };

  factory UserData.fromDocument(DocumentSnapshot snapshot) {
    return UserData.fromMap(snapshot.data());
  }

  // factory UserData.fromDocument(DocumentSnapshot snapshot) {
  //   return UserData(
  //     id: snapshot['id'],
  //     username: snapshot['username'],
  //     emailAddress: snapshot['emailAddress'],
  //     profilePhoto: snapshot['profilePhoto'],
  //   );
  // }
}
