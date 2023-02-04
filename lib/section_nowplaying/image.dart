import 'package:flutter/material.dart';

class SongImage extends StatelessWidget {
  const SongImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: 250,
            height: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.black),
          ),
        );
      },
    );
  }
}
