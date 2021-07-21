import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_test/screens/home.dart';
import 'package:flutterfire_test/services/flutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginAuth(),
    );
  }
}

class LoginAuth extends StatefulWidget {
  const LoginAuth({Key key}) : super(key: key);

  @override
  _LoginAuthState createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//TextEditingControllers are used for tracking changes to text fields
  TextEditingController _emailCon = TextEditingController();
  TextEditingController _pwdCon = TextEditingController();

  void _validateCred() async {
    FormState form = _formKey.currentState;
    if (form.validate()) {
      // _signInFirebase();
      // form.save();

      User result = await Auth().signIn(_emailCon.text, _pwdCon.text);

      if (result != null) {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool('login', false);
        sharedPreferences.setString('email', result.email);
        // await Session.setLogin(false);
        // await Session.setEmail(result.email);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } else {
      print('Form is invalid');
    }
  }

  // void _signInFirebase() async {
  //   try {
  //     final user = _auth.signInWithEmailAndPassword(
  //         email: _emailCon.text, password: _pwdCon.text);
  //     if (user != null) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomeScreen()),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                child: Text('LOGIN'),
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
