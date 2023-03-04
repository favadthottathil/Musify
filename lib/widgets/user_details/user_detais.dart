import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_application/DB/user_db.dart';
import 'package:music_application/DB/user_function.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({super.key});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  UserDB? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      appBar: AppBar(),
      body: ValueListenableBuilder(
        valueListenable: userNotifier,
        builder: (context, List<UserDB> userdetails, child) {
          for (final userdata in userdetails) {
            user = userdata;
          }

          return Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                Container(
                  height: 170,
                  width: 170,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
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
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        print('${user!.key}');

                        if (user?.key != null) {
                          deleteUser(user!.key);
                        } else {
                          print('failed to delete user');
                        }
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
