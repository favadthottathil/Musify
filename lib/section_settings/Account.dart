import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_application/DB/user_db.dart';
import 'package:music_application/DB/user_function.dart';
import 'package:music_application/widgets/user_details/user_detais.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _name = TextEditingController();

  final _email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       icon: const Icon(Icons.arrow_back_ios_new)),
      //   title: const Text('Account'),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: photo?.path == null
                    ? Container(
                        height: 140,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('Assets/img/UserAvathar.jpg'),
                          ),
                        ),
                      )
                    : Container(
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(
                                File(photo!.path),
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
              ),
              const SizedBox(height: 9),
              ElevatedButton.icon(
                onPressed: () {
                  addPhoto();
                },
                icon: const Icon(Icons.add_photo_alternate),
                label: const Text('Add Photo'),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  helperText: 'Enter Your Name',
                  helperStyle: const TextStyle(color: Colors.white, fontSize: 17),
                  hintText: 'Name',
                  hintStyle: const TextStyle(fontSize: 20),
                  filled: true,
                  fillColor: Colors.white54,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  helperText: 'Enter Your e-mail',
                  hintText: 'Email',
                  hintStyle: const TextStyle(fontSize: 20),
                  helperStyle: const TextStyle(color: Colors.white, fontSize: 17),
                  filled: true,
                  fillColor: Colors.white54,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white54),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addButtonPressed();
                  }
                },
                icon: const Icon(Icons.add, color: Colors.black),
                label: const Text(
                  'Add User',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addButtonPressed() async {
    final name = _name.text.trim();
    final email = _email.text.trim();

    if (name.isEmpty || email.isEmpty) {
      print('null');
      return;
    }

    final user = UserDB(name: name, email: email, photo: photo?.path ?? '');

    addUser(user);

    // Reset the form and photo after adding the user

    _formKey.currentState?.reset();

    setState(() {
      photo = null;
    });
  }

  File? photo;

  void addPhoto() async {
    // ignore: deprecated_member_use
    final photos = await ImagePicker().getImage(source: ImageSource.gallery);

    if (photos == null) {
      return;
    } else {
      final image = File(photos.path);
      setState(() {
        photo = image;
      });
    }
  }
}
