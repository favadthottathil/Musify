import 'package:flutter/material.dart';
import 'package:music_application/controller/song_controller.dart';
import 'package:music_application/provider/songmodel_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../playing_screen/now_playing.dart';

class Listtiles extends StatefulWidget {
  const Listtiles({super.key, required this.songModel});

  final List<SongModel> songModel;

  @override
  State<Listtiles> createState() => _ListtileState();
}

class _ListtileState extends State<Listtiles> {
  List<SongModel> allsongs = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.songModel.length,
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
                nullArtworkWidget: const Icon(Icons.music_note),
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
                                )),
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
                              ),
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
                                      Icons.delete,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                title: const Text(
                                  'Delete From Device',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
                                ),
                              ),
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
                              ),
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
