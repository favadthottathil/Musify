import 'package:flutter/material.dart';

class CustomButtomPlaylist extends StatelessWidget {
  const CustomButtomPlaylist({
    super.key,
    required this.color,
    required this.icon,
    required this.buttonname,
    this.buttonborer = false,
    required this.iconcolor,
    required this.textcolor,
  });

  final Color color;
  final IconData icon;
  final String buttonname;
  final bool buttonborer;
  final Color iconcolor;
  final Color textcolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
        border: buttonborer
            ? null
            : Border.all(
                width: 1,
                color: Colors.white38,
              ),
      ),
      child: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: iconcolor,
            ),
            const SizedBox(width: 1),
            Text(
              buttonname,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textcolor),
            ),
          ],
        ),
      ),
    );
  }
}
