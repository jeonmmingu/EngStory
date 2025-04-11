// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:eng_story/models/json_serializable.dart';

class StoryScript extends JsonSerializable {
  String id;
  String storyId;
  int index;
  String role;
  String text_en;
  String text_ko;

  StoryScript({
    required this.id,
    required this.storyId,
    required this.index,
    required this.role,
    required this.text_en,
    required this.text_ko,
  });

  factory StoryScript.fromMap(Map<String, dynamic> map) {
    return StoryScript(
      id: map['id'],
      storyId: map['storyId'],
      index: map['index'],
      role: map['role'],
      text_en: map['text_en'],
      text_ko: map['text_ko'],
    );
  }

  static List<StoryScript> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) {
      var scriptJson = json as Map<String, dynamic>;
      return StoryScript.fromMap(scriptJson);
    }).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storyId': storyId,
      'index': index,
      'role': role,
      'text_en': text_en,
      'text_ko': text_ko,
    };
  }
}
