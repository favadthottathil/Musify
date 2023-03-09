import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.name,
    required this.icon,
    required this.ontap,
  });

  final String name;

  final IconData icon;

  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              height: 50,
              width: 50,
              color: Colors.black45,
              child: Icon(icon, size: 30, color: Colors.white),
            ),
          ),
          const SizedBox(width: 20),
          Text(name, style: const TextStyle(fontSize: 26, color: Colors.white)),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.grey.shade400,
              width: 30,
              height: 30,
              child: const Icon(Ionicons.chevron_forward_outline),
            ),
          )
        ],
      ),
    );
  }
}
