import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music_application/DB/model_db.dart';
import 'package:music_application/screens/playlist/playlist_single_3.dart';
import 'package:music_application/widgets/playlist_widgets/custombottom_sheet.dart';
import 'package:music_application/widgets/playlist_widgets/play_list_customWidget.dart';

class AllPlaylist extends StatefulWidget {
  const AllPlaylist({super.key});

  @override
  State<AllPlaylist> createState() => _AllPlaylistState();
}

// final GlobalKey<FormState> formkey = GlobalKey<FormState>();
// TextEditingController namecontroller = TextEditingController();

class _AllPlaylistState extends State<AllPlaylist> {
  final TextEditingController namecontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // namecontroller.text =
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<SongsDB>('playlist').listenable(),
      builder: (context, Box<SongsDB> songlist, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(218, 3, 16, 56),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'PlayList',
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // namecontroller.clear();
                      // newplaylist(context, _formkey);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Ionicons.add_circle_outline, color: Colors.white, size: 40),
                        SizedBox(width: 10),
                        Text('Add PlayList', style: TextStyle(fontSize: 20, color: Colors.white))
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Hive.box<SongsDB>('playlist').isEmpty
                        ? const Center(
                            child: Text('No Playlist'),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              final data = songlist.values.toList()[index];
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
                                              builder: (context) => Playlist(playlist: data, index: index),
                                            ));
                                      },
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              color: Colors.white,
                                              child: const Icon(Icons.music_note),
                                            ),
                                          ),
                                          const SizedBox(width: 25),
                                          Column(
                                            children: [
                                              Text(
                                                data.name,
                                                maxLines: 1,
                                                style: const TextStyle(fontSize: 20, color: Colors.white),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                'Instrumental',
                                                style: TextStyle(fontSize: 15, color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                backgroundColor: const Color.fromARGB(218, 2, 12, 42),
                                                context: context,
                                                builder: (context) {
                                                  return CustomModelSheet(
                                                    firIcon: Ionicons.play_circle,
                                                    firText: 'Play',
                                                    firpress: () {},
                                                    secIcon: Icons.edit,
                                                    secText: 'Rename',
                                                    secpress: () {},
                                                    thirIcon: Icons.delete,
                                                    thirText: 'Delete Playlist',
                                                    thirpress: () {},
                                                    forIcon: Icons.share,
                                                    forText: 'Share',
                                                    forpress: () {},
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
                            itemCount: 6,
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
