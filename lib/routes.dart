import 'package:flutter/widgets.dart';
import 'package:flutterfire_test/main.dart';
import 'package:flutterfire_test/screens/home.dart';
import 'package:flutterfire_test/screens/login.dart';
import 'package:flutterfire_test/screens/register.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => PopupDialog(),
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/home': (context) => HomeScreen(),
};
