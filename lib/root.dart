import 'package:flutter/material.dart';

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class Root extends StatefulWidget {
  const Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
