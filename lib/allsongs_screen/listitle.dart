import 'package:flutter/material.dart';
import 'package:music_application/DB/favouritesDB.dart';
import 'package:music_application/controller/most_played.dart';
import 'package:music_application/controller/recent_song.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/playlist/playlist_allsngAdd.dart';
import 'package:music_application/provider/songmodel_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../playing_screen/now_playing.dart';

class Listtiles extends StatefulWidget {
  const Listtiles({super.key, required this.songModel, this.recentLength, this.isRecent = false});

  final List<SongModel> songModel;
  final dynamic recentLength;
  final bool isRecent;

  @override
  State<Listtiles> createState() => _ListtileState();
}

final GlobalKey<FormState> formkey = GlobalKey<FormState>();

TextEditingController namecontroller1 = TextEditingController();

class _ListtileState extends State<Listtiles> {
  List<SongModel> allsongs = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.isRecent ? widget.recentLength : widget.songModel.length,
      itemBuilder: (context, index) {
        allsongs.addAll(widget.songModel);
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black54,
            ),
            child: ListTile(
              leading: QueryArtworkWidget(
                id: widget.songModel[index].id,
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
                widget.songModel[index].displayNameWOExt,
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
                  widget.songModel[index].artist.toString(),
                  style: const TextStyle(color: Colors.white54),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.black45,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.white30,
                                  child: const Icon(
                                    Icons.playlist_add,
                                    size: 25,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              title: const Text(
                                'Add Playlist',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
                              ),
                              onTap: () {
                                modelsheet(context, widget.songModel[index], formkey);
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ValueListenableBuilder(
                              valueListenable: FavoriteDb.favoriteSongs,
                              builder: (context, List<SongModel> favouritedata, child) {
                                return ValueListenableBuilder(
                                    valueListenable: FavoriteDb.favoriteSongs,
                                    builder: (context, List<SongModel> data, child) {
                                      return ListTile(
                                        onTap: () {
                                          if (FavoriteDb.isFavor(widget.songModel[index])) {
                                            FavoriteDb.delete(widget.songModel[index].id);
                                            const remove = SnackBar(
                                              content: Text('Song Removed'),
                                              duration: Duration(seconds: 1),
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(remove);
                                          } else {
                                            FavoriteDb.add(widget.songModel[index]);
                                            const addfav = SnackBar(
                                              content: Text('Song Added'),
                                              duration: Duration(seconds: 1),
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(addfav);
                                          }
                                          FavoriteDb.favoriteSongs.notifyListeners();
                                        },
                                        leading: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            color: Colors.white30,
                                            child: const Icon(
                                              Icons.favorite,
                                              size: 25,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        title: const Text(
                                          'Add to Favourite',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
                                        ),
                                      );
                                    });
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () {},
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.white30,
                                    child: const Icon(
                                      Icons.details,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                title: const Text(
                                  'Details',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              onTap: () {
                GetAllSongController.audioPlayer.setAudioSource(
                  GetAllSongController.createSongList(widget.songModel),
                  initialIndex: index,
                );

                RecentController.addRecent(widget.songModel[index].id);

                MostlyPlayedfunctions.addplayCount(widget.songModel[index]);

                // MostlyPlayedfunctions.addplayCount(widget.songModel[index].id);

                context.read<SongModelProvider>().setId(widget.songModel[index].id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NowPlaying(
                      songModel: widget.songModel,
                      count: widget.songModel.length,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      controller: ScrollController(keepScrollOffset: true),
    );
  }
}
