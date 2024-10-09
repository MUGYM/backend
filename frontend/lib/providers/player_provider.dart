import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class PlayerProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String _accessToken = '';

  String get accessToken => _accessToken;

  void setAccessToken(String token) {
    _accessToken = token;
    notifyListeners();
  }

  Future<void> PlayTrack(String previewUrl) async {
    try {
      await _audioPlayer.setUrl(previewUrl);
      _audioPlayer.play();
    } catch (e) {
      print('Error playing track : $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
