import 'package:flutter/material.dart';

import 'package:music_application/section_mainScreen/Tab_Bar/all_songs.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.deepPurple[700],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const Text(
                  'Search',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 30),
                const SizedBox(
                  height: 800,
                  child: AllSongs(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Checkbox