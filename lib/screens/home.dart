import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_test/services/flutterfire.dart';

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
  User cUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    User currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        cUser = currentUser;
      });
    }
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
                await Auth().signOut();
                Navigator.popAndPushNamed(context, '/');
              },
            );
          })
        ],
      ),
      body: Container(
        child: Center(
          child: Text('Welcome, ' + cUser.email),
        ),
      ),
    );
  }
}
