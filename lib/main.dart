import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_application/DB/model_db.dart';
import 'package:music_application/DB/user_db.dart';

import 'package:music_application/mainScreen/main_screen.dart';
import 'package:music_application/provider/songmodel_provider.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserDBAdapter());
  if (!Hive.isAdapterRegistered(SongsDBAdapter().typeId)) {
    Hive.registerAdapter(SongsDBAdapter());
  }

  await Hive.openBox<int>('Favorite');
  await Hive.openBox('recentSongNotifier');
  await Hive.openBox<SongsDB>('playlist');
  await Hive.openBox('MostSongNotifier');
  await Hive.openBox<UserDB>('User');

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(ChangeNotifierProvider(
    create: (context) => SongModelProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Itim',
      ),
      home: const HomeScreen(),
    );
  }
}
