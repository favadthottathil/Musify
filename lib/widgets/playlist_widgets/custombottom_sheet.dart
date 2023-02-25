import 'package:flutter/material.dart';
import 'package:music_application/widgets/bottomsheet/bottomsheet%20_ist.dart';

class CustomModelSheet extends StatelessWidget {
  const CustomModelSheet({super.key, required this.firIcon, required this.firText, required this.firpress, required this.secIcon, required this.secText, required this.secpress, required this.thirIcon, required this.thirText, required this.thirpress, required this.forIcon, required this.forText, required this.forpress});

  final IconData firIcon;
  final String firText;
  final void Function() firpress;
  final IconData secIcon;
  final String secText;
  final void Function() secpress;
  final IconData thirIcon;
  final String thirText;
  final void Function() thirpress;
  final IconData forIcon;
  final String forText;
  final void Function() forpress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 25, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bottomsheetlist(
              icon: firIcon,
              title: firText,
              buttonpress: firpress,
            ),
            const SizedBox(height: 20),
            bottomsheetlist(
              title: secText,
              icon: secIcon,
              buttonpress: secpress,
            ),
            const SizedBox(height: 20),
            bottomsheetlist(
              title: thirText,
              icon: thirIcon,
              buttonpress: thirpress,
            ),
            const SizedBox(height: 20),
            bottomsheetlist(
              title: forText,
              icon: forIcon,
              buttonpress: forpress,
            )
          ],
        ),
      ),
    );
  }
}
