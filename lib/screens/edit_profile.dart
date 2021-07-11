import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_test/model/user_model.dart';
import 'package:flutterfire_test/services/firestore.dart';
import 'package:flutterfire_test/services/flutterfire.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class EditProfileScreen extends StatefulWidget {
  final UserData user;

  const EditProfileScreen({Key key, this.user}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _editUsername = TextEditingController();
  TextEditingController _editEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          Builder(builder: (BuildContext context) {
            return TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              child: Text('SAVE'),
              onPressed: () async {
                UserData userData = UserData(
                    username: _editUsername.text,
                    emailAddress: _editEmail.text);

                if (_formKey.currentState.validate()) {
                  await DatabaseServices.updateUser(
                      userData, _auth.currentUser.uid);
                  Navigator.popAndPushNamed(context, '/');
                } else {
                  print('unable to update form');
                }
              },
            );
          }),
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('accounts')
            .doc(_auth.currentUser.uid)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator());
          }

          UserData userData = UserData.fromDocument(snapshot.data);
          _editUsername.text = userData.username;
          _editEmail.text = userData.emailAddress;

          return Container(
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
// backgroundImage: AssetImage('assets/default-profile.png'),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _editUsername,
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                          validator: (value) =>
                              value.isEmpty ? 'Username cannot be blank' : null,
                        ),
                        TextFormField(
                          controller: _editEmail,
                          decoration:
                              const InputDecoration(labelText: 'Email Address'),
                          validator: (value) => value.isEmpty
                              ? 'Email address cannot be blank'
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
