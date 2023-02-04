import 'package:flutter/material.dart';

class LastAdded extends StatelessWidget {
  const LastAdded({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              height: 100,
              width: 100,
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
            ),
            const SizedBox(height: 10),
            const Text('Good 4 U', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text(
              'Olivia Rodrigo',
              style: TextStyle(color: Colors.white30, fontSize: 10),
            )
          ],
        );
      },
    );
  }
}
