import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music_application/DB/model_db.dart';
import 'package:music_application/DB/playlist_db.dart';
import 'package:music_application/playlist/playlist_single_3.dart';
import 'package:music_application/section_foryou/last_added.dart';
import 'package:music_application/widgets/bottomsheet/bottomsheet%20_ist.dart';
import 'package:music_application/widgets/playlist_widgets/custombottom_sheet.dart';

class PlaylistListview extends StatefulWidget {
  const PlaylistListview({
    super.key,
    required this.musicList,
  });

  final Box<SongsDB> musicList;

  @override
  State<PlaylistListview> createState() => _PlaylistListviewState();
}

class _PlaylistListviewState extends State<PlaylistListview> {
  TextEditingController nameeditcontroller0 = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final data = widget.musicList.values.toList()[index];

        // print('favad ====  ${data.songid} ${data.name}');

        return ValueListenableBuilder(
          valueListenable: Hive.box<SongsDB>('playlist').listenable(),
          builder: (BuildContext context, Box<SongsDB> musiclist, Widget? child) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Playlist(
                        playlist: data,
                        index: index,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('Assets/img/favad.jpg'),
                          fit: BoxFit.cover,
                        )),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        // const Text(
                        //   'Instrumental',
                        //   style: TextStyle(fontSize: 15, color: Colors.white),
                        // ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: const Color.fromARGB(218, 2, 12, 42),
                          context: context,
                          builder: (context) {
                            // return CustomModelSheet(
                            //   firIcon: Ionicons.play_circle,
                            //   firText: 'Play',
                            //   firpress: () {},
                            //   secIcon: Icons.edit,
                            //   secText: 'Rename',
                            //   secpress: () {
                            //     Navigator.of(context).pop();

                            //     editPlaylist(index, context, formkey, nameeditcontroller0, data);
                            //   },
                            //   thirIcon: Icons.delete,
                            //   thirText: 'Delete Playlist',
                            //   thirpress: () {
                            //     Navigator.of(context).pop();

                            //     deletePlaylist(context, musiclist, index);
                            //   },
                            //   forIcon: Icons.share,
                            //   forText: 'Share',
                            //   forpress: () {},
                            // );
                            return FractionallySizedBox(
                              heightFactor: 0.3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  bottomsheetlist(
                                    icon: Icons.edit,
                                    title: 'Rename',
                                    buttonpress: () {
                                      Navigator.of(context).pop();

                                      editPlaylist(index, context, formkey, nameeditcontroller0, data);
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  bottomsheetlist(
                                    title: 'Delete Playlist',
                                    icon: Icons.delete,
                                    buttonpress: () {
                                      Navigator.of(context).pop();

                                      deletePlaylist(context, musiclist, index);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      itemCount: widget.musicList.length,
    );
  }

  Future editPlaylist(index, context, formkey, namecontroller, SongsDB music) {
    namecontroller = TextEditingController(text: music.name);
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.black,
        children: [
          const SimpleDialogOption(
            child: Text(
              'Edit playlist name',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SimpleDialogOption(
            child: Form(
              key: formkey,
              child: TextFormField(
                maxLength: 12,
                controller: namecontroller,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter your playlist name';
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  updateplaylistname(index, formkey, namecontroller);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void updateplaylistname(index, formkey, playlistnamectrl) {
    if (formkey.currentState!.validate()) {
      final names = playlistnamectrl.text.trim();
      if (names.isEmpty) {
        return;
      } else {
        final playlistnam = SongsDB(name: names, songid: []);
        PlaylistDb.editlist(index, playlistnam);
      }
    }
  }

  Future<dynamic> deletePlaylist(context, musicList, index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Delete Playlist',
            style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
          ),
          content: const Text(
            'Are you sure you want to delete this playlist?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'No',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                musicList.deleteAt(index);
                Navigator.pop(context);
                final snackBar = SnackBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: MediaQuery.of(context).size.width * 3.5 / 5,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.black,
                  content: const Text(
                    'Playlist is deleted',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: const Duration(milliseconds: 450),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
