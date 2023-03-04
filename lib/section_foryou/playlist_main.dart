import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_application/DB/model_db.dart';

import 'package:music_application/playlist/playlist_single_3.dart';
import 'package:music_application/section_mainScreen/recently_played.dart';

class PlayListMain extends StatefulWidget {
  const PlayListMain({super.key});

  @override
  State<PlayListMain> createState() => _PlayListMainState();
}

class _PlayListMainState extends State<PlayListMain> {
  bool isrecent = true;
  dynamic recetlength;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<SongsDB>('playlist').listenable(),
      builder: (context, value, child) {
        return Container(
          child: Hive.box<SongsDB>('playlist').isEmpty
              ? const Center(
                  child: Text(
                    'No Playlist',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: isrecent
                      ? value.length > 5
                          ? 5
                          : value.length
                      : value.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = value.values.toList()[index];

                    return ValueListenableBuilder(
                      valueListenable: Hive.box<SongsDB>('playlist').listenable(),
                      builder: (context, musiclist, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Playlist(playlist: data, index: index),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                height: 140,
                                width: 140,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('Assets/img/favad.jpg'),
                                    fit: BoxFit.fitHeight,
                                  ),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 30),
                              child: Center(
                                child: Text(
                                  data.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
