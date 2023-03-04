import 'package:flutter/material.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';
import 'package:music_application/controller/recent_song.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/playing_screen/now_playing.dart';
import 'package:music_application/provider/songmodel_provider.dart';
import 'package:music_application/section_mainScreen/recently_played.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

List<String> name = [
  'Good 4 U',
  'Kiss Me More',
  'Butter'
];

class LastAdded extends StatefulWidget {
  const LastAdded({super.key});

  @override
  State<LastAdded> createState() => _LastAddedState();
}

class _LastAddedState extends State<LastAdded> {
  List<SongModel> lastplayed = [];
  List<SongModel> allsongs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    songsLastPlayed();
  }

  Future<void> songsLastPlayed() async {
    OnAudioQuery audioQuery = OnAudioQuery();

    lastplayed = await audioQuery.querySongs(sortType: SongSortType.DATE_ADDED);
    setState(() {
      allsongs = lastplayed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: allsongs.length,
      itemBuilder: (BuildContext context, int index) {
        SongModel song = allsongs.reversed.toList()[index];
        List<SongModel> listofsongs = allsongs.reversed.toList();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Column(
              children: [
                QueryArtworkWidget(
                  id: song.id,
                  type: ArtworkType.AUDIO,
                  artworkWidth: 80,
                  artworkHeight: 80,
                  nullArtworkWidget: const Icon(
                    Icons.music_note,
                    size: 70,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 20,
                  width: 100,
                  child: Text(
                    song.displayNameWOExt,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 15,
                  width: 70,
                  child: Text(
                    song.artist.toString(),
                    style: TextStyle(
                      color: Colors.white30,
                      fontSize: 10,
                    ),
                  ),
                )
              ],
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
        );
      },
    );
  }
}
