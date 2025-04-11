import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: null,
          child: Text(maxLines: 5, overflow: TextOverflow.ellipsis, "테스트 시작"),
        ),
      ),
    );
  }
}
