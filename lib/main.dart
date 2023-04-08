import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_application/DB/model_db.dart';
import 'package:music_application/providers/allsongs_provider.dart';
import 'package:music_application/providers/fovourite_provider.dart';
import 'package:music_application/providers/lastadded_provider.dart';
import 'package:music_application/providers/mostlyplayed_provider.dart';
import 'package:music_application/providers/nowplaying_provider.dart';
import 'package:music_application/providers/playlist_provider.dart';
import 'package:music_application/providers/recentsongs_provider.dart';
import 'package:music_application/providers/scanmusic_provider.dart';
import 'package:music_application/providers/search_provider.dart';
import 'package:music_application/providers/sleeptimer_provider.dart';
import 'package:music_application/songmodel_provider/songmodel_provider.dart';
import 'package:music_application/screens/settings/settings.dart';
import 'package:music_application/screens/splash/screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(SongsDBAdapter().typeId)) {
    Hive.registerAdapter(SongsDBAdapter());
  }

  await Hive.openBox<int>('Favorite');
  await Hive.openBox('recentSongNotifier');
  await Hive.openBox<SongsDB>('playlist');
  await Hive.openBox('MostSongNotifier');

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AllSongsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavouriteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MostlyPlayedProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RecentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LastAddedProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScanMusicProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SleepTimerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NowPlayingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        )
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Itim',
          ),
          home: const Splash(),
          routes: {
            "settings": (context) => const Settings(),
          },
        );
      }),
    );
  }
}
