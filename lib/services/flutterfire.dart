import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_test/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseAuth {
  Future<void> getCurrentUser();
  Future<User> signIn(String email, String password);
  Future<User> register(String username, String email, String password);
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  // @override
  // Future<User> getCurrentUser() async {
  //   // TODO: implement currentUser
  //   final User user = _firebaseAuth.currentUser;
  //   return user;
  // }
  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  String getCurrentUserID() {
    return _firebaseAuth.currentUser.uid;
  }

  @override
  Future<User> register(String username, String email, String password) async {
    // TODO: implement register
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User registeredUser = userCredential.user;
      return registeredUser;

      // this works!
      // if (registeredUser != null) {
      //   _fireStore.collection('accounts').doc(registeredUser.uid).set({
      //     'username': username,
      //     'email': email,
      //     'profilePhoto': '',
      //     //create snackbar
      //   });
      //   return registeredUser;
      // }
      // return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
      return null;
    }
  }

  @override
  Future<User> signIn(String email, String password) async {
    // TODO: implement signIn
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      final User signInUser = userCredential.user;
      return signInUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
      return null;
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    return _firebaseAuth.signOut();
  }
}
