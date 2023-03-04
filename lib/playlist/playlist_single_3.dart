import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ionicons/ionicons.dart';
import 'package:music_application/DB/model_db.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/playing_screen/now_playing.dart';
import 'package:music_application/playlist/playlist_addsongs.dart';
import 'package:music_application/provider/songmodel_provider.dart';
import 'package:music_application/widgets/mainscreen_widgets/appbar_icons.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// String?globalName;

class Playlist extends StatelessWidget {
  const Playlist({
    super.key,
    required this.playlist,
    required this.index,
  });

  final SongsDB playlist;
  final int index;

  @override
  Widget build(BuildContext context) {
    late List<SongModel> songPlaylist;

    return ValueListenableBuilder(
      valueListenable: Hive.box<SongsDB>('playlist').listenable(),
      builder: (BuildContext context, Box<SongsDB> music, child) {
        songPlaylist = listplaylist(music.values.toList()[index].songid);
        // print('findex $index');
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromARGB(218, 3, 16, 56),
            image: DecorationImage(image: AssetImage('Assets/img/backgrund.jpg'), fit: BoxFit.cover),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.5),
                    const Color.fromARGB(218, 3, 16, 56).withOpacity(1),
                    const Color.fromARGB(218, 3, 16, 56).withOpacity(1),
                  ],
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 300,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 40),
                              AppBarButton(
                                  iconData: Icons.arrow_back_ios,
                                  buttonAction: () {
                                    Navigator.pop(context);
                                  },
                                  color: Colors.white),
                              const SizedBox(height: 130),
                              Text(
                                playlist.name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white),
                              ),
                            ],
                          ),
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
                                // Wrap(
                                //   crossAxisAlignment: WrapCrossAlignment.center,
                                //   children: const [
                                //     Icon(
                                //       Icons.shuffle,
                                //       color: Colors.white,
                                //     ),
                                //     SizedBox(width: 5),
                                //     Text(
                                //       'Shuffle',
                                //       style: TextStyle(color: Colors.white),
                                //     ),
                                //   ],
                                // ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PlaylistAdd(playlist: playlist),
                                      ),
                                    );
                                  },
                                  child: Wrap(
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
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: const [
                      //     CustomButtomPlaylist(
                      //       buttonname: 'PLAY',
                      //       color: Colors.red,
                      //       icon: Icons.play_arrow,
                      //       buttonborer: true,
                      //       iconcolor: Colors.black,
                      //       textcolor: Colors.black,
                      //     ),
                      //     CustomButtomPlaylist(
                      //       color: Colors.transparent,
                      //       icon: Icons.shuffle,
                      //       buttonname: 'SHUFFLE',
                      //       iconcolor: Colors.white,
                      //       textcolor: Colors.white,
                      //     )
                      //   ],
                      // ),
                      SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: songPlaylist.isEmpty
                            ? const Center(
                                child: Text(
                                  'Playlist Empty??',
                                  style: TextStyle(color: Colors.white, fontSize: 30),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: songPlaylist.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: QueryArtworkWidget(
                                              id: songPlaylist[index].id,
                                              type: ArtworkType.AUDIO,
                                              artworkWidth: 50,
                                              artworkHeight: 50,
                                              keepOldArtwork: true,
                                              nullArtworkWidget: Container(
                                                color: Colors.white,
                                                height: 50,
                                                width: 50,
                                                child: const Icon(
                                                  Icons.music_note,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 25),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  songPlaylist[index].displayNameWOExt,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  songPlaylist[index].artist.toString(),
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          AppBarButton(
                                            color: Colors.white,
                                            iconData: Ionicons.remove,
                                            buttonAction: () {
                                              songDeleteFromPlaylist(songPlaylist[index], context);
                                            },
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        GetAllSongController.audioPlayer.setAudioSource(GetAllSongController.createSongList(songPlaylist), initialIndex: index);

                                        // context.read<SongModelProvider>().setId(songPlaylist[index].id);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NowPlaying(
                                              songModel: songPlaylist,
                                              count: songPlaylist.length,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                        // : Listtiles(songModel: songPlaylist),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<SongModel> listplaylist(List<int> data) {
    List<SongModel> playsong = [];

    for (int i = 0; i < GetAllSongController.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetAllSongController.songscopy[i].id == data[j]) {
          playsong.add(GetAllSongController.songscopy[i]);
        }
      }
    }
    return playsong;
  }

  void songDeleteFromPlaylist(SongModel data, context) {
    playlist.deletedata(data.id);

    final removePlaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width: 200,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: const Text(
        'Song removed from playlist',
        style: TextStyle(color: Colors.white),
      ),
      duration: const Duration(milliseconds: 550),
    );

    ScaffoldMessenger.of(context).showSnackBar(removePlaylist);
  }
}
