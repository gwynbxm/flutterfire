import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String displayEmail = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCurrentUser();
    getData();
  }

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
              },
            );
          })
        ],
      ),
      body: Container(
        child: Center(
          child: Text('Welcome, ' + '$displayEmail'),
        ),
      ),
    );
  }
}
