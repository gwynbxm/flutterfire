import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_test/routes.dart';
import 'package:flutterfire_test/screens/login.dart';
import 'package:flutterfire_test/screens/register.dart';

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
      initialRoute: '/',
      routes: routes,
    );
  }
}

class PopupDialog extends StatefulWidget {
  const PopupDialog({Key key}) : super(key: key);

  @override
  _PopupDialogState createState() => _PopupDialogState();
}

class _PopupDialogState extends State<PopupDialog> {
  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Do you want to login or sign up?'),
            actions: [
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  child: Text('LOGIN')),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/register'),
                child: Text('SIGN UP'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: _showDialog,
          child: Text('CLICK HERE'),
        ),
      ),
    );
  }
}
