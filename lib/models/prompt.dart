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
    const promptText =
        '이야기를 생성할 때 아래 조건을 반드시 따라야 한다. 먼저 하나의 Story 객체를 생성하고, 이어서 최소 40개 이상의 StoryScript 객체를 JSON 형식으로 20개씩 끊어서 순차적으로 제공한다. Story 객체는 JSON 형식으로 전달하고, 필드는 id(제목과 동일한 한글 문자열), title, source(“chatGPT”), category(한글, 예: “과학 탐험”), readTime(“1-5 min” 또는 “5-10 min”), storyLevel(1~4 사이 정수)로 구성하며, updatedAt은 포함하지 않는다. StoryScript 리스트도 JSON 형식으로 전달하며, 각 객체는 id(“스토리 제목_스크립트 번호” 형식), storyId(Story의 id와 동일), index(1부터 순차 증가), role(“story_teller” 또는 “me”, 단 최소 8:1 비율로 storyteller 우세), text_en(영어 대사), text_ko(자연스러운 한글 번역) 필드를 포함해야 하고, updatedAt은 포함하지 않는다. 스크립트 응답은 무조건 JSON 형식으로만 제공되며, 20개 단위로 나누어 응답하되 마지막은 20개 미만이어도 괜찮다. Story 객체와 StoryScript는 모두 앞서 제시한 포맷을 정확히 지켜 생성해야 한다.';
    final categoryText = displayCategoryTextFromString(category);
    final readTimeText = readTime == 'short' ? '1-5 min' : '5-10 min';
    final toneText = displayToneTextFromString(tone);
    return '$promptText\n\n이야기 생성\n제목: $title\n내용: $content\n분위기: $mood\n카테고리: $categoryText\n소요시간: $readTimeText\n말투: $toneText';
  }
}
