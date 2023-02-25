import 'package:flutter/material.dart';

class bottomsheetlist extends StatelessWidget {
  bottomsheetlist({super.key, required this.title, required this.icon, required this.buttonpress});

  final String title;
  final IconData icon;
  void Function() buttonpress;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconButton(
          onPressed: buttonpress,
          icon: Icon(icon, size: 30),
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
