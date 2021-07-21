import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_test/routes.dart';
import 'package:flutterfire_test/screens/home.dart';
import 'package:flutterfire_test/screens/login.dart';
import 'package:flutterfire_test/screens/popup.dart';
import 'package:flutterfire_test/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlutterFireApp());
}

class FlutterFireApp extends StatelessWidget {
  const FlutterFireApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Fire App',
      // initialRoute: '/',
      // routes: routes,
      home: PopupDialog(),
    );
  }
}
