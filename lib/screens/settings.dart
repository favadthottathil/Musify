import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music_application/DB/playlist_db.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/mainScreen/main_screen.dart';
import 'package:music_application/section_settings/about_us.dart';
import 'package:music_application/section_settings/feedback_form.dart';
import 'package:music_application/section_settings/privacy&policy.dart';
import 'package:music_application/section_settings/scan_music.dart';
import 'package:music_application/section_settings/settings_tile.dart';
import 'package:music_application/section_settings/termofuse.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(218, 3, 16, 56),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(218, 3, 16, 56),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              SettingsTile(
                name: 'Scan Music',
                icon: Ionicons.shield_checkmark_outline,
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanMusic(),
                      ));
                },
              ),
              const SizedBox(height: 10),
              SettingsTile(
                name: 'Reset',
                icon: Icons.restore,
                ontap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.black,
                        title: const Text(
                          'Reset',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        content: const Text(
                          'reset all data',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('NO')),
                          ElevatedButton(
                              onPressed: () {
                                PlaylistDb.reset(context);
                              },
                              child: const Text('Yes'))
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 40),
              SettingsTile(
                  name: 'Feedback',
                  icon: Icons.feedback,
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeedbackForm(),
                        ));
                  }),
              const SizedBox(height: 10),
              SettingsTile(
                  name: 'Privacy and Policy',
                  icon: Icons.privacy_tip,
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyAndPolicy(),
                        ));
                  }),
              const SizedBox(height: 10),
              SettingsTile(
                  name: 'Terms of use',
                  icon: Ionicons.document,
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermOfUse(),
                        ));
                  }),
              const SizedBox(height: 10),
              SettingsTile(
                  name: 'About Us',
                  icon: Icons.emoji_emotions_sharp,
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutScreen(),
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
