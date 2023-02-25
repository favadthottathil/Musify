import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
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
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 10),
              SettingsTile(name: 'Account', icon: Ionicons.person),
              SizedBox(height: 30),
              SettingsTile(name: 'Scan Music', icon: Ionicons.shield_checkmark_outline),
              SizedBox(height: 10),
              SettingsTile(name: 'Sleep Timer', icon: Ionicons.timer),
              SizedBox(height: 10),
              SettingsTile(name: 'Language', icon: Ionicons.language),
              SizedBox(height: 30),
              SettingsTile(name: 'Feedback', icon: Icons.feedback),
              SizedBox(height: 10),
              SettingsTile(name: 'Privacy and Policy', icon: Icons.privacy_tip),
              SizedBox(height: 10),
              SettingsTile(name: 'About Us', icon: Icons.emoji_emotions),
            ],
          ),
        ),
      ),
    );
  }
}
