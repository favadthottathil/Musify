import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(218, 3, 16, 56),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(218, 3, 16, 56),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 60,
                    height: 80,
                    color: Colors.black45,
                    child: const Icon(
                      Icons.scanner,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                title: const Text(
                  'Scan music',
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 60,
                    height: 80,
                    color: Colors.black45,
                    child: const Icon(
                      Icons.alarm,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                title: const Text(
                  'Sleep timer',
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 60,
                    height: 80,
                    color: Colors.black45,
                    child: const Icon(
                      Icons.language,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                title: const Text(
                  'Language',
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 60,
                    height: 80,
                    color: Colors.black45,
                    child: const Icon(
                      Icons.feedback,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                title: const Text(
                  'Feedback',
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 60,
                    height: 80,
                    color: Colors.black45,
                    child: const Icon(
                      Icons.policy,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                title: const Text(
                  'Privacy policy',
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 60,
                    height: 80,
                    color: Colors.black45,
                    child: const Icon(
                      Icons.edit_document,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                title: const Text(
                  'Term of use',
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
