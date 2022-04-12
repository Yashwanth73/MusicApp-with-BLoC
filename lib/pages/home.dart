import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:music_app_getx/bloc/track_list_bloc.dart';
import 'package:music_app_getx/models/track_list_model.dart';
import 'package:music_app_getx/pages/details.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final trackBloc = TrackListBloc();
  @override
  void initState() {
    trackBloc.eventSink.add(TrackAction.fetch);
    super.initState();
  }

  @override
  void dispose() {
    trackBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Trending Tracks"),
          centerTitle: true,
        ),
        body: StreamBuilder<List<TrackList>>(
            stream: trackBloc.trackStream,
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (_, index) {
                    var albumName = snapshot.data?[index].track.albumName;
                    var trackName = snapshot.data?[index].track.trackName;
                    var artistName = snapshot.data?[index].track.artistName;
                    var trackId = snapshot.data?[index].track.trackId;
                    var trackRating = snapshot.data?[index].track.trackRating;
                    var explicit = snapshot.data?[index].track.explicit;
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.music_note),
                        title: Text(trackName.toString()),
                        subtitle: Text(albumName.toString()),
                        trailing: SizedBox(
                          width: 70,
                          child: Text(artistName.toString()),
                        ),
                        onTap: () => Get.to(() => TrackDetails(
                            int.parse(trackId.toString()),
                            trackName.toString(),
                            albumName.toString(),
                            int.parse(explicit.toString()),
                            int.parse(trackRating.toString()),
                            artistName.toString())),
                      ),
                    );
                  });
            }));
  }
}
