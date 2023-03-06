import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: const Color.fromARGB(255, 20, 5, 46),
      ),
      backgroundColor: const Color.fromARGB(255, 20, 5, 46),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            ''' 
            Welcome to Musicly, the ultimate destination for music lovers! We are a team of passionate music enthusiasts who have come together to create a unique and user-friendly music app that caters to all your musical needs.
      
      Our app offers a vast collection of music from different genres, languages, and eras, so you can easily discover and listen to your favorite tracks anytime, anywhere. We understand the importance of music in your life and how it can uplift your mood and bring joy to your day, which is why we strive to offer the best possible listening experience through our app.
      
      At Musicly, we believe that music is a universal language that connects people from all walks of life. That's why we encourage our users to share their playlists, discover new music, and connect with like-minded individuals who share their love for music.
      
      Our team works tirelessly to ensure that our app is always up-to-date with the latest music releases, so you never miss out on your favorite artist's new tracks. We also offer personalized recommendations based on your listening habits, so you can discover new music that you'll love.
      
      Whether you're commuting, working out, or relaxing at home, Musicly is the perfect companion for all your music needs. So, join our community of music lovers today and experience the joy of music like never before!
            ''',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
