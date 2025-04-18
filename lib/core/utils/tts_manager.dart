import 'dart:io';

import 'package:eng_story/repositories/local/cached_speech_speed_repository.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsManager {
  CachedSpeechSpeedRepository cachedSpeechSpeedRepository =
      CachedSpeechSpeedRepository();

  static final TtsManager _instance = TtsManager._internal();
  factory TtsManager() => _instance;
  TtsManager._internal();

  FlutterTts flutterTts = FlutterTts();
  FlutterTts testTts = FlutterTts();

  Future<void> init() async {
    final speechRate = await cachedSpeechSpeedRepository.getSpeechSpeed();

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
    await flutterTts.setSpeechRate(speechRate);
    await flutterTts.setVolume(0.8);
    await flutterTts.setPitch(1.0);

    // testTts도 동일하게 설정
    if (Platform.isAndroid) {
      await testTts.setLanguage("en-US");
      await testTts.setVoice(
        {
          'name': 'en-US-default',
          'locale': 'eng-default',
        },
      );
    } else {
      await testTts.setLanguage("en-US");
    }
    await testTts.setSpeechRate(speechRate);
    await testTts.setVolume(0.8);
    await testTts.setPitch(1.0);
  }

  void speak(String text) {
    // Speak the text
    flutterTts.speak(text);
  }

  Future<void> stop() async {
    // Stop the TTS
    await flutterTts.stop();
  }

  void testSpeak(String text) {
    // Speak the text
    testTts.speak(text);
  }

  /// 🔹 TTS 음성 속도 설정
  /// isTest가 true일 경우 testTts에 적용
  /// isTest가 false일 경우 flutterTts에 적용
  Future<void> setSpeechRate(
    double rate,
    bool isTest,
  ) async {
    // Set the speech rate
    if (isTest) {
      await testTts.setSpeechRate(rate);
    } else {
      await flutterTts.setSpeechRate(rate);
      await cachedSpeechSpeedRepository.saveSpeechSpeed(rate);
    }
  }
}
