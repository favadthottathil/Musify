import 'package:flutter/material.dart';
import 'package:music_application/providers/lastadded_provider.dart';
import 'package:music_application/providers/mostlyplayed_provider.dart';
import 'package:music_application/providers/recentsongs_provider.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/playing_screen/now_playing.dart';
import 'package:music_application/songmodel_provider/songmodel_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class LastAdded extends StatelessWidget {
  LastAdded({super.key});

  @override
  Widget build(BuildContext context) {
    final lastAddedProvider = Provider.of<LastAddedProvider>(context, listen: false);

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: lastAddedProvider.allsongs.length,
      itemBuilder: (BuildContext context, int index) {
        SongModel song = lastAddedProvider.allsongs.reversed.toList()[index];
        List<SongModel> listofsongs = lastAddedProvider.allsongs.reversed.toList();

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
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
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
                SizedBox(
                  height: 15,
                  width: 70,
                  child: Text(
                    song.artist.toString(),
                    style: const TextStyle(
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

              Provider.of<RecentProvider>(context, listen: false).addRecent(listofsongs[index].id);

              Provider.of<MostlyPlayedProvider>(context, listen: false).addMostlyPlayed(listofsongs[index]);

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
