import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_test/model/user_model.dart';
import 'package:flutterfire_test/screens/login.dart';
import 'package:flutterfire_test/services/firestore.dart';
import 'package:flutterfire_test/services/flutterfire.dart';

import 'home.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: RegisterAccount(),
    );
  }
}

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({Key key}) : super(key: key);

  @override
  _RegisterAccountState createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//TextEditingControllers are used for tracking changes to text fields
  TextEditingController _usernameCon = TextEditingController();
  TextEditingController _emailCon = TextEditingController();
  TextEditingController _pwdCon = TextEditingController();

  bool _success;

  //check for null fields & invalid
  //check whether email exist in db
//else save into db and show snackbar saying successful account creation

  void _validateCred() async {
    FormState form = _formKey.currentState;
    if (form.validate()) {
      // _registerToFirebase();

      User user = await Auth()
          .register(_usernameCon.text, _emailCon.text, _pwdCon.text);
      if (user != null) {
        UserData userData =
            UserData(username: _usernameCon.text, emailAddress: _emailCon.text);
        await DatabaseServices.addUser(user.uid, userData);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } else {
      print('Form is invalid');
    }
  }

  void _registerToFirebase() async {
    try {
      _auth.createUserWithEmailAndPassword(
          email: _emailCon.text, password: _pwdCon.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _usernameCon,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) =>
                    value.isEmpty ? 'Username cannot be blank' : null,
              ),
              TextFormField(
                controller: _emailCon,
                decoration: const InputDecoration(labelText: 'Email Address'),
                validator: (value) =>
                    value.isEmpty ? 'Email cannot be blank' : null,
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _pwdCon,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) =>
                    value.isEmpty ? 'Password cannot be blank' : null,
              ),
              ElevatedButton(
                onPressed: _validateCred,
                child: Text('SUBMIT'),
              )
            ],
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailCon.dispose();
    _pwdCon.dispose();
  }
}
