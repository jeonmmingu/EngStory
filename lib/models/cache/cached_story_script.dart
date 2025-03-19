import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:eng_story/models/story_script.dart';

part 'cached_story_script.g.dart';

@HiveType(typeId: 1) // 다른 모델과 겹치지 않도록 typeId 설정
class CachedStoryScript extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String storyId;

  @HiveField(2)
  int index;

  @HiveField(3)
  String role;

  @HiveField(4)
  String textEn;

  @HiveField(5)
  String textKo;

  @HiveField(6)
  DateTime updatedAt; // Hive에서는 DateTime을 사용

  CachedStoryScript({
    required this.id,
    required this.storyId,
    required this.index,
    required this.role,
    required this.textEn,
    required this.textKo,
    required this.updatedAt,
  });

  /// 🔹 Firestore `StoryScript` → `CachedStoryScript` 변환
  factory CachedStoryScript.fromStoryScript(StoryScript script) {
    return CachedStoryScript(
      id: script.id,
      storyId: script.storyId,
      index: script.index,
      role: script.role,
      textEn: script.text_en,
      textKo: script.text_ko,
      updatedAt: script.updatedAt.toDate(), // 🔹 Timestamp → DateTime 변환
    );
  }

  /// 🔹 `CachedStoryScript` → Firestore `StoryScript` 변환
  StoryScript toStoryScript() {
    return StoryScript(
      id: id,
      storyId: storyId,
      index: index,
      role: role,
      text_en: textEn,
      text_ko: textKo,
      updatedAt: Timestamp.fromDate(updatedAt), // 🔹 DateTime → Timestamp 변환
    );
  }

  /// 🔹 JSON → `CachedStoryScript` 변환
  factory CachedStoryScript.fromJson(Map<String, dynamic> json) {
    return CachedStoryScript(
      id: json['id'] as String,
      storyId: json['storyId'] as String,
      index: json['index'] as int,
      role: json['role'] as String,
      textEn: json['text_en'] as String,
      textKo: json['text_ko'] as String,
      updatedAt: (json['updatedAt'] as Timestamp).toDate(), // 🔹 Timestamp → DateTime 변환
    );
  }

  /// 🔹 `CachedStoryScript` → JSON 변환 (Firestore 저장용)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storyId': storyId,
      'index': index,
      'role': role,
      'text_en': textEn,
      'text_ko': textKo,
      'updatedAt': Timestamp.fromDate(updatedAt), // 🔹 DateTime → Timestamp 변환
    };
  }
}