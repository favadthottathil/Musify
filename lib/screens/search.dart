import 'package:flutter/material.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(218, 3, 16, 56),
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
          color: const Color.fromARGB(218, 3, 16, 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const Text(
                  'Search',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                // TextFormField(
                //   decoration: const InputDecoration(
                //     filled: true,
                //     fillColor: Colors.white,
                //     hintText: 'Search',
                //     hintStyle: TextStyle(
                //       color: Colors.black54,
                //       fontWeight: FontWeight.w500,
                //     ),
                //     prefixIcon: Icon(Icons.search),
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(15),
                //         ),
                //         borderSide: BorderSide.none),
                //   ),
                // ),

                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(218, 3, 16, 56),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 200,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              hintText: 'Search the music',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 110),
                          child: Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.5),
                            size: 30,
                          ),
                        ),
                      ],
                    ),
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