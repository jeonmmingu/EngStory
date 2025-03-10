import 'package:flutter/material.dart';
import 'story_repository_test.dart';

class TestScreen extends StatelessWidget {
  final testManager = StoryRepositoryTest(); // 원하는 테스트 클래스로 변경

  TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async =>
              await testManager.runAllTests(), // 원하는 테스트 함수로 변경
          child: const Text("테스트 시작"),
        ),
      ),
    );
  }
}
