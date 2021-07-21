import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_test/model/user_model.dart';
import 'package:flutterfire_test/services/flutterfire.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final CollectionReference accountCollections =
    _firestore.collection('accounts');

class DatabaseServices {
  static User registeredUser;

  static Future<void> addUser(
    String uid,
    UserData userData,
  ) async {
    await accountCollections
        .doc(uid)
        .set(userData.toMap())
        .whenComplete(() => print("User added"))
        .catchError((e) => print(e));
  }

  static Future<void> getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await accountCollections.doc(uid).get();
    return documentSnapshot;
  }

  //for StreamBuilder
  Stream<QuerySnapshot> getAllUsers() {
    Stream<QuerySnapshot> queryUsers = accountCollections.snapshots();
    return queryUsers;
  }

  static Future<void> updateUser(UserData userData, String uid) async {
    await accountCollections
        .doc(uid)
        .update(userData.toMap())
        .whenComplete(() => print("User updated"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteUser({String docId}) async {
    await accountCollections
        .doc(registeredUser.uid)
        .delete()
        .whenComplete(() => print("User deleted"))
        .catchError((e) => print(e));
  }
}
