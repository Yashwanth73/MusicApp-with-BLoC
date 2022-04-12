import 'package:flutter/material.dart';
import 'package:music_app_getx/bloc/lyrics_bloc.dart';

import '../models/lyrics_model.dart';

// import 'package:music_app_getx/models/lyrics_model.dart';
late TrackLyrics tracklyrics;

// ignore: must_be_immutable
class TrackDetails extends StatefulWidget {
  // ignore: non_constant_identifier_names
  int track_id;
  // ignore: non_constant_identifier_names
  final String track_name;
  // ignore: non_constant_identifier_names
  final String album_name;
  // ignore: non_constant_identifier_names
  final String artist_name;
  int explicit;
  int rating;
  TrackDetails(this.track_id, this.track_name, this.album_name, this.explicit,
      this.rating, this.artist_name,
      {Key? key})
      : super(key: key);

  @override
  State<TrackDetails> createState() => _TrackDetailsState();
}

class _TrackDetailsState extends State<TrackDetails> {
  @override
  void initState() {
    int id = widget.track_id;
    String apiUrl =
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id={$id}&apikey=9e6cf541cfcccb85bf480ee6a701e433";
    final lyricsBloc = LyricsBloc(apiUrl);

    lyricsBloc.eventSink.add(LyricsAction.fetch);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.explicit);
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRACK DETAILS"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "Name:\n",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.track_name + "\n",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            const Text(
              "Artist:\n",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(widget.artist_name + "\n",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            const Text(
              "Album Name:\n",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.album_name + "\n",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            const Text(
              "Explicit:\n",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.explicit == 0 ? "False \n" : "True \n",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            const Text(
              "Rating:\n",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.rating.toString() + "\n",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 5),
            const Text(
              "Lyrics:\n",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<Lyrics>(builder: (_, snapshot) {
              var body = snapshot.data?.lyricsBody;
              if (snapshot.hasData) {
                return Text(
                  body.toString(),
                  style: const TextStyle(fontSize: 18),
                );
              } else {
                return const Text(
                  "No Lyrics",
                  style: TextStyle(fontSize: 18),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
