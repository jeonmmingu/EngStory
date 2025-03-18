import 'package:eng_story/models/story.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'cached_story.g.dart';

@HiveType(typeId: 0) // TypeId는 다른 모델과 겹치지 않게 설정
class CachedStory extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String source;

  @HiveField(3)
  String category;

  @HiveField(4)
  String readTime;

  @HiveField(5)
  DateTime updatedAt; // Hive에서는 DateTime 사용

  @HiveField(6)
  int lastReadScriptIndex; // 🔹 마지막으로 읽은 script index (캐싱 전용)

  CachedStory({
    required this.id,
    required this.title,
    required this.source,
    required this.category,
    required this.readTime,
    required this.updatedAt,
    this.lastReadScriptIndex = 0, // 기본값: 0 (처음부터 시작)
  });

  /// 🔹 Firestore `Story` 객체를 `CachedStory`로 변환
  factory CachedStory.fromStory(Story story, {int lastReadScriptIndex = 0}) {
    return CachedStory(
      id: story.id,
      title: story.title,
      source: story.source,
      category: story.category,
      readTime: story.readTime,
      updatedAt: story.updatedAt.toDate(), // Timestamp → DateTime 변환
      lastReadScriptIndex: lastReadScriptIndex, // 기본값 0 또는 저장된 값 사용
    );
  }

  /// 🔹 `CachedStory`를 Firestore `Story`로 변환
  Story toStory() {
    return Story(
      id: id,
      title: title,
      source: source,
      category: category,
      readTime: readTime,
      updatedAt: Timestamp.fromDate(updatedAt), // DateTime → Timestamp 변환
    );
  }

  /// 🔹 Firestore에서 받아온 JSON → `CachedStory` 변환
  factory CachedStory.fromJson(Map<String, dynamic> json) {
    return CachedStory(
      id: json['id'] as String,
      title: json['title'] as String,
      source: json['source'] as String,
      category: json['category'] as String,
      readTime: json['readTime'] as String,
      updatedAt: (json['updatedAt'] as Timestamp).toDate(), // Firestore Timestamp → DateTime 변환
    );
  }

  /// 🔹 `CachedStory`를 JSON으로 변환 (Firestore 저장용) → lastReadScriptIndex 제외
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'source': source,
      'category': category,
      'readTime': readTime,
      'updatedAt': Timestamp.fromDate(updatedAt), // DateTime → Timestamp 변환
    };
  }
}