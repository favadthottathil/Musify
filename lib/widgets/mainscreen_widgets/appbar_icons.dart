import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({super.key, required this.iconData, required this.buttonAction, required this.color, this.size = 20});

  final IconData iconData;
  final void Function() buttonAction;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: buttonAction,
      icon: Icon(
        iconData,
        size: size,
        color: color,
      ),
    );
  }
}
