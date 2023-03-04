import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_application/controller/recent_song.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/playing_screen/now_playing.dart';
import 'package:music_application/provider/songmodel_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class LastAddedSongs extends StatefulWidget {
  LastAddedSongs({super.key});

  @override
  State<LastAddedSongs> createState() => _LastAddedSongsState();
}

class _LastAddedSongsState extends State<LastAddedSongs> {
  List<SongModel> lastPlayedSongs = [];

  List<SongModel> allsongs = [];

  @override
  void initState() {
    super.initState();

    songsLastPlayed();
  }

  Future<void> songsLastPlayed() async {
    OnAudioQuery audioQuery = OnAudioQuery();

    lastPlayedSongs = await audioQuery.querySongs(sortType: SongSortType.DATE_ADDED);
    setState(() {
      allsongs = lastPlayedSongs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 3, 16, 56),
      body: SingleChildScrollView(
        child: SafeArea(
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
                      'Last Added',
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: allsongs.length,
                  itemBuilder: (context, index) {
                    SongModel song = allsongs.reversed.toList()[index];
                    List<SongModel> listofsongs = allsongs.reversed.toList();

                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black54,
                        ),
                        child: ListTile(
                          leading: QueryArtworkWidget(
                            id: song.id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: const Padding(
                              padding: EdgeInsets.only(left: 7, top: 6),
                              child: Icon(
                                Icons.music_note,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          title: Text(
                            song.displayNameWOExt,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              song.artist.toString(),
                              style: const TextStyle(color: Colors.white54),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          onTap: () {
                            GetAllSongController.audioPlayer.setAudioSource(
                              GetAllSongController.createSongList(listofsongs),
                              initialIndex: index,
                            );

                            RecentController.addRecent(listofsongs[index].id);

                            // MostlyPlayedfunctions.addToMostPlayed(widget.songModel[index]);

                            context.read<SongModelProvider>().setId(listofsongs[index].id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NowPlaying(
                                  songModel: listofsongs,
                                  count: listofsongs.length,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  controller: ScrollController(keepScrollOffset: true),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
