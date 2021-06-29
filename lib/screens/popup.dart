import 'package:flutter/material.dart';
import 'package:flutterfire_test/screens/home.dart';
import 'package:flutterfire_test/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class PopupDialog extends StatefulWidget {
  const PopupDialog({Key key}) : super(key: key);

  @override
  _PopupDialogState createState() => _PopupDialogState();
}

class _PopupDialogState extends State<PopupDialog> {
  SharedPreferences sharedPreferences;
  bool newUser;

  String displayEmail = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfSignedIn();
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Do you want to login or sign up?'),
            actions: [
              TextButton(
                  onPressed: () =>
                      // Navigator.pushReplacementNamed(context, '/login'),
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen())),
                  child: Text('LOGIN')),
              TextButton(
                onPressed: () =>
                    // Navigator.pushReplacementNamed(context, '/register'),
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen())),
                child: Text('SIGN UP'),
              ),
            ],
          );
        });
  }

  void checkIfSignedIn() async {
    sharedPreferences = await SharedPreferences.getInstance();
    newUser = (sharedPreferences.getBool('login') ?? true);

    if (newUser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
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
