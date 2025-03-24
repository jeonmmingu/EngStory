import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_story/core/enums/story_category.dart';
import 'package:eng_story/core/enums/story_tone.dart';
import 'package:eng_story/models/json_serializable.dart';

class Prompt implements JsonSerializable {
  // title, content, mood, category, readTime, tone
  final String title;
  final String content;
  final String mood;
  final String category;
  final String readTime;
  final String tone;
  // createdAt
  final Timestamp createdAt; // promptId로 사용
  // prompt Text
  final String promptText;

  Prompt({
    required this.title,
    required this.content,
    required this.mood,
    required this.category,
    required this.readTime,
    required this.tone,
    required this.createdAt,
    required this.promptText,
  });

  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
      title: json['title'],
      content: json['content'],
      mood: json['mood'],
      category: json['category'],
      readTime: json['readTime'],
      tone: json['tone'],
      createdAt: json['createdAt'],
      promptText: json['promptText'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'mood': mood,
      'category': category,
      'readTime': readTime,
      'tone': tone,
      'createdAt': createdAt,
      'promptText': promptText,
    };
  }

  static String makePromptText(String title, String content, String mood,
      String category, String readTime, String tone) {
    final categoryText = displayCategoryTextFromString(category);
    final readTimeText = readTime == 'short' ? '1-5 min' : '5-10 min';
    final toneText = displayToneTextFromString(tone);
    return '이야기 생성\n제목: $title\n내용: $content\n분위기: $mood\n카테고리: $categoryText\n소요시간: $readTimeText\n말투: $toneText';
  }
}
