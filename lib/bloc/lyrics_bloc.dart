import 'dart:async';
import 'dart:convert';
import 'package:music_app_getx/models/lyrics_model.dart';

import 'package:http/http.dart' as http;

enum LyricsAction { fetch, delete }

class LyricsBloc {
  final _stateStreamController = StreamController<Lyrics>();
  StreamSink<Lyrics> get _lyricsSink => _stateStreamController.sink;
  Stream<Lyrics> get lyricsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<LyricsAction>();
  StreamSink<LyricsAction> get eventSink => _eventStreamController.sink;
  Stream<LyricsAction> get _eventStream => _eventStreamController.stream;

  LyricsBloc(String url) {
    _eventStream.listen((event) async {
      if (event == LyricsAction.fetch) {
        try {
          var lyrics = await getLyrics(url);
          // ignore: unnecessary_null_comparison
          if (lyrics != null) _lyricsSink.add(lyrics.message.body.lyrics);
          // ignore: unused_catch_clause
        } on Exception catch (e) {
          _lyricsSink.addError("Something Went Wrong");
        }
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}

Future<TrackLyrics> getLyrics(String apiUrl) async {
  // String apiUrl =
  //     "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id={$id}&apikey=9e6cf541cfcccb85bf480ee6a701e433";
  final response = await http.get(Uri.parse(apiUrl));
  final jsonresponse = json.decode(response.body);
  final lyrics = TrackLyrics.fromJson(jsonresponse);
  return lyrics;
}
