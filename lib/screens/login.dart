import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
      ),
    );
  }
}

class LoginAuth extends StatefulWidget {
  const LoginAuth({Key key}) : super(key: key);

  @override
  _LoginAuthState createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
