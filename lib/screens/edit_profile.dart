import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_test/model/user_model.dart';
import 'package:flutterfire_test/services/firestore.dart';
import 'package:flutterfire_test/services/flutterfire.dart';
import 'package:flutterfire_test/services/storage.dart';
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

  File _pickedFile;

  _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.black,
                    ),
                    title: Text('Take photo'),
                    onTap: () {
                      _cameraImage();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.photo_library_outlined,
                      color: Colors.black,
                    ),
                    title: Text('Choose existing photo'),
                    onTap: () {
                      _galleryImage();
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.highlight_remove_outlined,
                      color: Colors.red,
                    ),
                    title: Text('Remove photo'),
                    onTap: () {},
                  )
                ],
              ),
            ),
          );
        });
  }

  _cameraImage() async {
    PickedFile img = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _pickedFile = File(img.path);
    });
  }

  _galleryImage() async {
    PickedFile img = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _pickedFile = File(img.path);
    });
  }

  void updateProfile() async {
    String pickedFileUrl = '';

    if (_formKey.currentState.validate()) {
      if (_pickedFile != null) {
        pickedFileUrl = await StorageService.uploadProfilePhoto(
            _pickedFile.path, _pickedFile, _auth.currentUser.uid);
      }
      UserData userData = UserData(
          username: _editUsername.text,
          emailAddress: _editEmail.text,
          profilePhoto: pickedFileUrl);

      await DatabaseServices.updateUser(userData, _auth.currentUser.uid);
      Navigator.popAndPushNamed(context, '/');
    } else {
      print('unable to update form');
    }
  }

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
              onPressed: updateProfile,
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

          return SafeArea(
            child: Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _showPicker(context),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: userData?.profilePhoto?.isEmpty ?? true
                            ? AssetImage('assets/default-profile.png')
                            : NetworkImage(userData.profilePhoto),
                        child: _pickedFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _pickedFile,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fitHeight,
                                ))
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(50)),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _editUsername,
                            decoration:
                                const InputDecoration(labelText: 'Username'),
                            validator: (value) => value.isEmpty
                                ? 'Username cannot be blank'
                                : null,
                          ),
                          TextFormField(
                            controller: _editEmail,
                            decoration: const InputDecoration(
                                labelText: 'Email Address'),
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
            ),
          );
        },
      ),
    );
  }
}
