import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_application/DB/model_db.dart';
import 'package:music_application/allsongs_screen/listitle.dart';
import 'package:music_application/playlist/all_playlist%20_1.dart';
import 'package:on_audio_query/on_audio_query.dart';

modelsheet(BuildContext context, SongModel songModel, formkey) {
  return showModalBottomSheet(
    backgroundColor: const Color.fromARGB(218, 3, 16, 56),
    context: context,
    builder: (context) {
      return SizedBox(
        height: 500,
        width: double.maxFinite,
        child: ValueListenableBuilder(
          valueListenable: Hive.box<SongsDB>('playlist').listenable(),
          builder: (context, Box<SongsDB> playlist, child) {
            return Container(
              child: Hive.box<SongsDB>('playlist').isEmpty
                  ? InkWell(
                      onTap: () {
                        newplaylist(context, formkey);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Create New Playlist',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Icon(
                            Icons.playlist_add,
                            size: 30,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            // namecontroller1.clear();
                            newplaylist(context, formkey);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'Create',
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.add),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: playlist.length,
                          itemBuilder: (context, index) {
                            final data = playlist.values.toList()[index];
                            return ListTile(
                              title: Text(
                                data.name,
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  songAddedToPlaylist(context, songModel, data, data.name);
                                },
                                icon: const Icon(Icons.playlist_add),
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            );
          },
        ),
      );
    },
  );
}

songAddedToPlaylist(BuildContext context, SongModel song, datas, String name) {
  if (!datas.isvalue(song.id)) {
    datas.add(song.id);
    final snackbar1 = SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.black,
      content: Text(
        'Song added to $name',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar1);
    Navigator.pop(context);
  } else {
    final snackbar2 = SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.black,
      content: Text('Song already exists in $name'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar2);
    Navigator.pop(context);
  }
}
