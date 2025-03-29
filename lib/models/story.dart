import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_story/models/json_serializable.dart';

class Story implements JsonSerializable {
  String id;
  String title;
  String source;
  String category;
  String readTime;
  int storyLevel;
  Timestamp updatedAt;
  bool isDeleted;

  Story({
    required this.id,
    required this.title,
    required this.source,
    required this.category,
    required this.readTime,
    required this.storyLevel,
    required this.updatedAt,
    this.isDeleted = false,
  });

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['id'],
      title: map['title'],
      source: map['source'],
      category: map['category'],
      readTime: map['readTime'],
      storyLevel: map['storyLevel'],
      updatedAt: map['updatedAt'],
      isDeleted: map['isDeleted'] ?? false,
    );
  }

  factory Story.fromJson(String jsonString) {
    final Map<String, dynamic> map = jsonDecode(jsonString);
    map['updatedAt'] = Timestamp.fromDate(DateTime.parse(map['updatedAt']));
    map['readTime'] = (map['readTime']);
    return Story.fromMap(map);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'source': source,
      'category': category,
      'readTime': readTime,
      'storyLevel': storyLevel,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted,
    };
  }
}
