class Track {
  final String name;
  final String artist;
  final String previewUrl;

  Track({required this.name, required this.artist, required this.previewUrl});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      name: json['name'],
      artist: json['artist'],
      previewUrl: json['preview_url'],
    );
  }
}
