import 'package:eng_story/core/tests/test_screen.dart';
import 'package:eng_story/router/router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // Go Router 설정
      routerConfig: router,
      debugShowCheckedModeBanner: false, // Debug 배너 없애기
    );
  }
}
