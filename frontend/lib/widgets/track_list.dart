import 'package:flutter/material.dart';
import 'package:frontend/models/track.dart';

class TrackList extends StatelessWidget {
  TrackList({super.key});

  final List<Track> tracks = [
    Track(name: 'song 1', artist: 'artist 1', previewUrl: 'https://1'),
    Track(name: 'song 2', artist: 'artist 2', previewUrl: 'https://2'),
    Track(name: 'song 3', artist: 'artist 3', previewUrl: 'https://3'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(tracks[index].name),
          subtitle: Text(tracks[index].artist),
        );
      },
    );
  }
}
