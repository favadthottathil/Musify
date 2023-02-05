import 'package:flutter/material.dart';

List<String> name = [
  'Good 4 U',
  'Kiss Me More',
  'Butter'
];

List<dynamic> images = [
  'Assets/img/butter.jpg',
  'Assets/img/good for you.jpg',
  'Assets/img/Kiss me more.jpg',
  'Assets/img/butter.jpg',
];

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const NowPlaying(songModel: items,),
                // ));
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(image: AssetImage(images[index]), fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(name[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )),
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
