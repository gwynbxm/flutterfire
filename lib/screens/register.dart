import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
      ),
    );
  }
}

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({Key key}) : super(key: key);

  @override
  _RegisterAccountState createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
