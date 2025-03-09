import 'package:eng_story/models/json_serializable.dart';

class Story implements JsonSerializable {
  String id;
  String title;
  String source;
  String category;
  String readTime;
  String updatedAt;

  Story({
    required this.id,
    required this.title,
    required this.source,
    required this.category,
    required this.readTime,
    required this.updatedAt,
  });

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['id'],
      title: map['title'],
      source: map['source'],
      category: map['category'],
      readTime: map['readTime'],
      updatedAt: map['updatedAt'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'source': source,
      'category': category,
      'readTime': readTime,
      'updatedAt': updatedAt,
    };
  }
}
