import 'dart:io';

import 'package:dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_application/DB/user_db.dart';
import 'package:music_application/DB/user_function.dart';
import 'package:music_application/section_settings/Account.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  UserDB? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                if (user?.key != null) {
                  deleteUser(user?.key);
                }
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      body: ValueListenableBuilder(
        valueListenable: userNotifier,
        builder: (context, List<UserDB> userdetails, child) {
          for (final userdata in userdetails) {
            user = userdata;
          }

          if (userdetails.isEmpty) {
            return const Account();
          }

          return Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                user!.photo!.isNotEmpty
                    ? Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(
                                File(user?.photo ?? 'No Photo'),
                              ),
                              fit: BoxFit.cover),
                        ),
                      )
                    : Container(
                        height: 170,
                        width: 170,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('Assets/img/UserAvathar.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                // Container(
                //   height: 170,
                //   width: 170,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     shape: BoxShape.circle,
                //     image: DecorationImage(
                //         image: FileImage(
                //           File(user?.photo ?? 'No Photo'),
                //         ),
                //         fit: BoxFit.cover),
                //   ),
                // ),
                const SizedBox(height: 20),
                Text(
                  user?.name ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  user?.email ?? 'unknown',
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        final choice = ChoiceDialog(
                          dialogBackgroundColor: Colors.black45,
                          title: 'Delete User',
                          titleColor: Colors.white,
                          message: 'Are You Really Want to Remove This User',
                          messageColor: Colors.white,
                          buttonOkText: 'Delete',
                          buttonOkColor: Colors.red,
                          buttonOkOnPressed: () {
                            if (user?.key != null) {
                              deleteUser(user?.key);
                              Navigator.pop(context);
                            }
                          },
                          buttonCancelBorderColor: Colors.white,
                          buttonCancelOnPressed: () {
                            Navigator.pop(context);
                          },
                        );
                        choice.show(context);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete User'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit User'),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
