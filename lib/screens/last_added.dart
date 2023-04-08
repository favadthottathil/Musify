import 'package:flutter/material.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/playing_screen/now_playing.dart';
import 'package:music_application/providers/lastadded_provider.dart';
import 'package:music_application/providers/recentsongs_provider.dart';
import 'package:music_application/songmodel_provider/songmodel_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class LastAddedSongs extends StatelessWidget {
  const LastAddedSongs({super.key});

  // @override
  // void initState() {
  //   super.initState();

  //   songsLastPlayed();
  // }

  @override
  Widget build(BuildContext context) {
    final lastAddedProvider = Provider.of<LastAddedProvider>(context, listen: false);

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
                const SizedBox(height: 40),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: lastAddedProvider.allsongs.length,
                  itemBuilder: (context, index) {
                    SongModel song = lastAddedProvider.allsongs.reversed.toList()[index];
                    List<SongModel> listofsongs = lastAddedProvider.allsongs.reversed.toList();

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

                            Provider.of<RecentProvider>(context, listen: false).addRecent(listofsongs[index].id);

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
