import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfire_test/main.dart';
import 'package:flutterfire_test/screens/home.dart';
import 'package:flutterfire_test/screens/login.dart';
import 'package:flutterfire_test/screens/popup.dart';
import 'package:flutterfire_test/screens/register.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (context) => PopupDialog(),
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/home': (context) => HomeScreen(),
};

// class Routes {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (context) => PopupDialog());
//         break;
//       case '/login':
//         return MaterialPageRoute(builder: (context) => LoginScreen());
//         break;
//       default:
//         return MaterialPageRoute(builder: (context) => PopupDialog());
//     }
//   }
// }
