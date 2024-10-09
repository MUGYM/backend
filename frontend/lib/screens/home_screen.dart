import 'package:flutter/material.dart';
import 'package:frontend/screens/player_screen.dart';
import '../widgets/custom_button.dart';
import 'search_screen.dart'; // search_screen.dart 파일을 가져옵니다.

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Go to Player',
              onPressed: () {
                debugPrint("Button clicked for Player!");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlayerScreen()),
                );
              },
            ),
            const SizedBox(height: 20), // 여백 추가
            CustomButton(
              text: 'Go to Search',
              onPressed: () {
                debugPrint("Button clicked for Search!");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const SearchScreen()), // search_screen으로 이동
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
