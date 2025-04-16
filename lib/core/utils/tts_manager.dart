import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';

class TtsManager {
  static final TtsManager _instance = TtsManager._internal();
  factory TtsManager() => _instance;
  TtsManager._internal();

  FlutterTts flutterTts = FlutterTts();

  Future<void> init() async {
    if (Platform.isAndroid) {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setVoice(
        {
          'name': 'en-US-default',
          'locale': 'eng-default',
        },
      );
    } else {
      await flutterTts.setLanguage("en-US");
    }
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(0.8);
    await flutterTts.setPitch(1.0);
  }

  void speak(String text) {
    // Speak the text
    flutterTts.speak(text);
  }

  Future<void> stop() async {
    // Stop the TTS
    await flutterTts.stop();
  }
}
