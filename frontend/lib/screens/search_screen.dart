import 'package:flutter/material.dart';
import 'package:frontend/services/spotify_api.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchTracks() async {
    try {
      // Access token 받아오기
      final accessToken =
          Provider.of<PlayerProvider>(context, listen: false).accessToken;

      if (accessToken.isEmpty) {
        // Access token이 없을 때 오류 처리
        throw Exception('Access token is missing or invalid');
      }

      // 검색 중 로딩 상태
      setState(() {
        _isLoading = true;
      });

      // Spotify API를 사용해 검색 요청 보내기
      final query = _searchController.text;
      _searchResults =
          await SpotifyApiService().searchTracks(query, accessToken);

      // 검색 결과가 제대로 왔는지 디버깅용 출력
      debugPrint('Search results: $_searchResults');
    } catch (e) {
      // 오류 발생 시 로그 출력
      debugPrint('Error while searching: $e');
    } finally {
      // 검색 완료 후 로딩 상태 해제
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Tracks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search for a song',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _searchTracks,
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _searchResults.isEmpty
                      ? const Center(child: Text('No results found'))
                      : ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final track = _searchResults[index];
                            return ListTile(
                              title: Text(track['name']),
                              subtitle: Text(track['artists'][0]['name']),
                              onTap: () {
                                Provider.of<PlayerProvider>(context,
                                        listen: false)
                                    .PlayTrack(track['preview_url']);
                              },
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
