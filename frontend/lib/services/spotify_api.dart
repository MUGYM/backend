import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/track.dart';

class SpotifyApiService {
  final String backendUrl = 'http://127.0.0.1:8000/';

  Future<List<Track>> searchTracks(String query, String accessToken) async {
    final response = await http.get(
      Uri.parse('$backendUrl/search-track?query=$query'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Track> tracks = (data['tracks'] as List)
          .map((trackJson) => Track.fromJson(trackJson))
          .toList();
      return tracks;
    } else {
      throw Exception('Failed to search tracks');
    }
  }
}
