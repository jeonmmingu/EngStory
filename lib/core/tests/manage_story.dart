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

  // 로컬 캐시 데이터
  final Map<String, Story> _stories = {};
  final Map<String, List<StoryScript>> _storyScripts = {};

  /// 📌 스토리 추가 및 Firestore 저장
  Future<void> addStory(Story story) async {
    _stories[story.id] = story;
    await _storyRepository.createStory(story.id, story); // Firestore 저장
  }

  /// 📌 특정 스토리 가져오기 (로컬 -> 없으면 Firestore)
  Future<Story?> getStory(String storyId) async {
    if (_stories.containsKey(storyId)) {
      return _stories[storyId];
    } else {
      Story? story = await _storyRepository.readStory(storyId);
      if (story != null) {
        _stories[storyId] = story;
      }
      return story;
    }
  }

  /// 📌 스토리 전체 가져오기
  List<Story> getAllStories() {
    return _stories.values.toList();
  }

  /// 📌 스토리 삭제 (Firestore & 로컬)
  Future<void> deleteStory(String storyId) async {
    _stories.remove(storyId);
    _storyScripts.remove(storyId);
    await _storyRepository.deleteStory(storyId);
  }

  /// 📌 스토리 스크립트 추가 및 Firestore 저장
  Future<void> addStoryScripts(
      String storyId, List<StoryScript> scripts) async {
    _storyScripts[storyId] = scripts;
    try {
      for (var script in scripts) {
        await _storyRepository.createStoryScript(storyId, script.id, script);
      }
    } catch (e) {
      print("스토리 스크립트 추가 에러: $e");
    }
  }

  /// 📌 특정 스토리의 스크립트 가져오기 (로컬 -> Firestore)
  Future<List<StoryScript>?> getStoryScripts(String storyId) async {
    if (_storyScripts.containsKey(storyId)) {
      return _storyScripts[storyId];
    } else {
      List<StoryScript> scripts =
          await _storyRepository.readStoryScripts(storyId);
      if (scripts.isNotEmpty) {
        _storyScripts[storyId] = scripts;
      }
      return scripts;
    }
  }

  /// 📌 스토리 스크립트 삭제
  Future<void> deleteStoryScripts(String storyId) async {
    _storyScripts.remove(storyId);
    await _storyRepository.deleteAllStoryScripts(storyId);
  }
}
