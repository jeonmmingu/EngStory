import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/story_script.dart';
import 'package:eng_story/repositories/remote/story_repository.dart';

class ManageStory {
  // 싱글턴 인스턴스
  static final ManageStory _instance = ManageStory._internal();

  // 내부 생성자
  ManageStory._internal();

  // 싱글턴 인스턴스 반환
  factory ManageStory() => _instance;

  // StoryRepository 인스턴스
  final StoryRepository _storyRepository = StoryRepository();

  /// 📌 스토리 추가 및 Firestore 저장
  Future<void> addStory(Story story) async {
    await _storyRepository.createStory(story.id, story); // Firestore 저장
  }

  /// 📌 스토리 삭제 (Hard delete)
  Future<void> deleteStory(String storyId) async {
    try {
      await _storyRepository.deleteStory(storyId);
    } catch (e) {
      rethrow;
    }
  }

  /// 📌 스토리 삭제 (Soft delete)
  Future<void> softDeleteStory(String storyId) async {
    try {
      await _storyRepository.updateStory(
        storyId,
        {
          "isDeleted": true,
          "updatedAt": Timestamp.now(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  /// 📌 스토리 스크립트 추가 및 Firestore 저장
  Future<void> addStoryScripts(
      String storyId, List<StoryScript> scripts) async {
    try {
      for (var script in scripts) {
        await _storyRepository.createStoryScript(storyId, script.id, script);
      }
    } catch (e) {
      print("스토리 스크립트 추가 에러: $e");
    }
  }
}
