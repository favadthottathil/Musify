import 'package:flutter/material.dart';

class OutLineButton extends StatelessWidget {
  const OutLineButton({
    super.key,
    required this.onpressed,
  });

  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          width: 1,
          color: Colors.white54,
        ),
      ),
      onPressed: onpressed,
      child: const Text(
        'More',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class NameHome extends StatelessWidget {
  const NameHome({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
