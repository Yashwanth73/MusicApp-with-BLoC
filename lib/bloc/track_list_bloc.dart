import 'dart:async';

import 'dart:convert';
import 'package:music_app_getx/models/track_list_model.dart';
import 'package:http/http.dart' as http;

import '../models/track_list_model.dart';

enum TrackAction { fetch, delete }

class TrackListBloc {
  final _stateStreamController = StreamController<List<TrackList>>();
  StreamSink<List<TrackList>> get _trackSink => _stateStreamController.sink;
  Stream<List<TrackList>> get trackStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<TrackAction>();
  StreamSink<TrackAction> get eventSink => _eventStreamController.sink;
  Stream<TrackAction> get _eventStream => _eventStreamController.stream;

  TrackListBloc() {
    _eventStream.listen((event) async {
      if (event == TrackAction.fetch) {
        try {
          var track = await getListTrack();
          // ignore: unnecessary_null_comparison
          if (track != null) _trackSink.add(track.message.body.trackList);
          // ignore: unused_catch_clause
        } on Exception catch (e) {
          _trackSink.addError("Something Went Wrong");
        }
      }
    });
  }
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}

Future<ListTrack> getListTrack() async {
  String apiUrl =
      "https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=9e6cf541cfcccb85bf480ee6a701e433";

  final response = await http.get(Uri.parse(apiUrl));

  final jsonresponse = json.decode(response.body);
  final listTrack = ListTrack.fromJson(jsonresponse);

  return listTrack;
}
