import 'package:eng_story/models/story.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'cached_story.g.dart';

@HiveType(typeId: 0)
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
  DateTime updatedAt;

  @HiveField(6)
  int lastReadScriptIndex;

  @HiveField(7)
  int storyLevel;

  CachedStory({
    required this.id,
    required this.title,
    required this.source,
    required this.category,
    required this.readTime,
    required this.updatedAt,
    required this.storyLevel,
    this.lastReadScriptIndex = 0,
  });

  factory CachedStory.fromStory(Story story,
      {int lastReadScriptIndex = 0}) {
    return CachedStory(
      id: story.id,
      title: story.title,
      source: story.source,
      category: story.category,
      readTime: story.readTime,
      updatedAt: story.updatedAt.toDate(),
      lastReadScriptIndex: lastReadScriptIndex,
      storyLevel: story.storyLevel,
    );
  }

  Story toStory() {
    return Story(
      id: id,
      title: title,
      source: source,
      category: category,
      readTime: readTime,
      storyLevel: storyLevel,
      updatedAt: Timestamp.fromDate(updatedAt),
    );
  }

  factory CachedStory.fromJson(Map<String, dynamic> json) {
    return CachedStory(
      id: json['id'] as String,
      title: json['title'] as String,
      source: json['source'] as String,
      category: json['category'] as String,
      readTime: json['readTime'] as String,
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
      storyLevel: json['storyLevel'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'source': source,
      'category': category,
      'readTime': readTime,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'storyLevel': storyLevel,
    };
  }
}
