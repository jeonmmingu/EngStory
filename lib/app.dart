import 'package:eng_story/core/tests/test_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: TestScreen(), // 테스트 할 기능이 있을 때 사용
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Eng Story'),
        ),
        body: const Center(
          child: Text('Welcome to Eng Story'),
        ),
      ),
    );
  }
}
