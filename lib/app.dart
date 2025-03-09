import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
