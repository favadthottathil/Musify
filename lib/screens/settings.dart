import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music_application/mainScreen/main_screen.dart';
import 'package:music_application/section_settings/Account%20_main.dart';
import 'package:music_application/section_settings/Account.dart';
import 'package:music_application/section_settings/feedback_form.dart';
import 'package:music_application/section_settings/scan_music.dart';
import 'package:music_application/section_settings/settings_tile.dart';

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
              const SizedBox(height: 10),
              SettingsTile(
                name: 'Account',
                icon: Ionicons.person,
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserLogin(),
                      ));
                },
              ),
              const SizedBox(height: 30),
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
              SettingsTile(name: 'Sleep Timer', icon: Ionicons.timer, ontap: () {}),
              const SizedBox(height: 40),
              SettingsTile(
                  name: 'Feedback',
                  icon: Icons.feedback,
                  ontap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const FeedbackForm(),
                    //     ));
                  }),
              const SizedBox(height: 10),
              SettingsTile(name: 'Privacy and Policy', icon: Icons.privacy_tip, ontap: () {}),
              const SizedBox(height: 10),
              SettingsTile(name: 'About Us', icon: Icons.emoji_emotions, ontap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
