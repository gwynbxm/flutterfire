import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_test/model/user_model.dart';
import 'package:flutterfire_test/screens/edit_profile.dart';
import 'package:flutterfire_test/screens/popup.dart';
import 'package:flutterfire_test/services/firestore.dart';
import 'package:flutterfire_test/services/flutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

// class HomeApp extends StatelessWidget {
//   final User user;
//
//   const HomeApp({Key key, this.user}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//         actions: [
//           Builder(builder: (BuildContext context) {
//             return TextButton(
//               style: TextButton.styleFrom(
//                 primary: Colors.white,
//               ),
//               child: Text('SIGN OUT'),
//               onPressed: () async {
//                 await Auth().signOut();
//                 Navigator.popAndPushNamed(context, '/');
//               },
//             );
//           })
//         ],
//       ),
//       body: HomeScreen(),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // User cUser;
  SharedPreferences sharedPreferences;
  String displayEmail, username = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCurrentUser();
    getData();
    // displayEmail = Session.getEmail();
  }
  //
  // void getCurrentUser() {
  //   User currentUser = FirebaseAuth.instance.currentUser;
  //
  //   if (currentUser != null) {
  //     setState(() {
  //       cUser = currentUser;
  //     });
  //   }
  // }

  getData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      displayEmail = sharedPreferences.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          Builder(builder: (BuildContext context) {
            return TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              child: Text('SIGN OUT'),
              onPressed: () async {
                sharedPreferences.remove('email');
                sharedPreferences.setBool('login', true);
                await Auth().signOut();
                Navigator.popAndPushNamed(context, '/');

                // Session.logout();
                // await Session.setLogin(true);
                // Navigator.pop(context);
              },
            );
          })
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('accounts')
            .doc(_auth.currentUser.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator());
          }

          UserData userData = UserData.fromDocument(snapshot.data);

          return Container(
            child: Center(
              // child: Text('Welcome, ' + '$displayEmail'),
              child: ListView(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.transparent,
                    backgroundImage: userData?.profilePhoto?.isEmpty ?? true
                        ? AssetImage('assets/default-profile.png')
                        : NetworkImage(userData.profilePhoto),
                  ),
                  Text(
                    userData.username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(userData.emailAddress),
                  // Text('$username', style: TextStyle(fontWeight: FontWeight.bold),),
                  // Text('$displayEmail'),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen())),
                    child: Text('Edit'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
