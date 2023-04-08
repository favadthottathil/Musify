import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music_application/providers/playlist_provider.dart';
import 'package:music_application/screens/settings/widgets/about_us.dart';
import 'package:music_application/screens/settings/widgets/feedback_form.dart';
import 'package:music_application/screens/settings/widgets/privacy&policy.dart';
import 'package:music_application/screens/settings/widgets/scan_music.dart';
import 'package:music_application/screens/settings/widgets/settings_tile.dart';
import 'package:music_application/screens/settings/widgets/sleep_tiimer.dart';
import 'package:music_application/screens/settings/widgets/termofuse.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
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
      body: Padding(
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
                      builder: (context) => ScanMusic(),
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
                              Provider.of<PlayListProvider>(context, listen: false).reset(context);
                            },
                            child: const Text('Yes'))
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            SettingsTile(
              name: 'Sleep Timer',
              icon: Ionicons.timer,
              ontap: () {
                showDialog(
                  context: context,
                  builder: (context) => SleepTimer(),
                );
              },
            ),
            const SizedBox(height: 40),
            SettingsTile(
                name: 'Feedback',
                icon: Icons.feedback,
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackForm(),
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
    );
  }
}
