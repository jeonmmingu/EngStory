import 'package:flutter_tts/flutter_tts.dart';

class TtsManager {
  static final TtsManager _instance = TtsManager._internal();
  factory TtsManager() => _instance;
  TtsManager._internal();

  FlutterTts flutterTts = FlutterTts();

  Future<void> init() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  Future<void> changeLanguage(String language) async {
    await flutterTts.setLanguage(language);
  }

  Future<void> changeSpeechRate(double rate) async {
    await flutterTts.setSpeechRate(rate);
  }

  Future<void> changeVolume(double volume) async {
    await flutterTts.setVolume(volume);
  }

  Future<void> changePitch(double pitch) async {
    await flutterTts.setPitch(pitch);
  }

  Future<void> changeVoice(Map<String, String> voice) async {
    await flutterTts.setVoice(voice);
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
