import 'package:flutter/material.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';
import 'package:music_application/widgets/mainscreen_widgets/appbar_icons.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(218, 3, 16, 56),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    image: DecorationImage(image: AssetImage('Assets/img/austin-neill-hgO1wFPXl3I-unsplash.jpg'), fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 60,
                      left: 10,
                      child: Container(
                        width: 70,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white30,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new)),
                      ),
                    ),
                    Positioned(
                      left: 320,
                      top: 55,
                      child: Container(
                        width: 70,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white30,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [
                            Icon(
                              Icons.shuffle,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Shuffle',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Add Song',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CustomButtomPlaylist(
                    buttonname: 'PLAY',
                    color: Colors.red,
                    icon: Icons.play_arrow,
                    buttonborer: true,
                    iconcolor: Colors.black,
                    textcolor: Colors.black,
                  ),
                  CustomButtomPlaylist(
                    color: Colors.transparent,
                    icon: Icons.shuffle,
                    buttonname: 'SHUFFLE',
                    iconcolor: Colors.white,
                    textcolor: Colors.white,
                  )
                ],
              ),
              SizedBox(
                height: 400,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        color: Colors.amber,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 75,
                              width: 90,
                              color: Colors.black,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Song Name',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                                ),
                                Text('Artist name')
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: AppBarButton(iconData: Icons.more_vert_rounded, buttonAction: () {}),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
