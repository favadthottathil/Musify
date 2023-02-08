import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({super.key, required this.iconData, required this.buttonAction});

  final IconData iconData;
  final void Function() buttonAction;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: buttonAction,
      icon: Icon(
        iconData,
        size: 30,
      ),
    );
  }
}
