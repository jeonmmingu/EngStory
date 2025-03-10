import 'package:eng_story/repositories/story_repository.dart';
import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/story_script.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryRepositoryTest {
  static final StoryRepositoryTest _instance = StoryRepositoryTest._internal();
  factory StoryRepositoryTest() => _instance;
  StoryRepositoryTest._internal();

  final StoryRepository storyRepository = StoryRepository();

  final String testStoryId = "test_story_123";
  final String testScriptId = "test_script_123";

  // 스토리 생성 테스트
  Future<void> createStoryTest() async {
    final testStory = Story(
      id: testStoryId,
      title: "테스트 스토리",
      source: "Public Domain",
      category: "동화",
      readTime: "5-10 min",
      updatedAt: Timestamp.now(),
    );

    await storyRepository.createStory(testStoryId, testStory);
    print("✅ 스토리 생성 완료: ${testStory.title}");
  }

  // 스토리 읽기 테스트
  Future<void> readStoryTest() async {
    final story = await storyRepository.readStory(testStoryId);
    if (story != null) {
      print("✅ 스토리 읽기 성공: ${story.title}");
    } else {
      print("❌ 스토리 읽기 실패");
    }
  }

  // 스토리 업데이트 테스트
  Future<void> updateStoryTest() async {
    await storyRepository.updateStory(testStoryId, {"title": "업데이트된 스토리"});
    print("✅ 스토리 업데이트 완료");
  }

  // 스토리 삭제 테스트
  Future<void> deleteStoryTest() async {
    await storyRepository.deleteStory(testStoryId);
    print("✅ 스토리 삭제 완료");
  }

  // 스토리스크립트 생성 테스트
  Future<void> createStoryScriptTest() async {
    final testScript = StoryScript(
      id: testScriptId,
      storyId: testStoryId,
      index: 1,
      role: "story_teller",
      text_en: "Hello",
      text_ko: "안녕",
      updatedAt: Timestamp.now(),
    );

    await storyRepository.createStoryScript(
        testStoryId, testScriptId, testScript);
    print("✅ 스토리스크립트 생성 완료: ${testScript.text_en}");
  }

  // 스토리스크립트 읽기 테스트
  Future<void> readStoryScriptsTest() async {
    final scripts = await storyRepository.readStoryScripts(testStoryId);
    if (scripts.isNotEmpty) {
      print("✅ 스토리스크립트 읽기 성공: ${scripts.length} 개");
    } else {
      print("❌ 스토리스크립트 읽기 실패");
    }
  }

  // 스토리스크립트 업데이트 테스트
  Future<void> updateStoryScriptTest() async {
    await storyRepository.updateStoryScript(
        testStoryId, testScriptId, {"text_en": "Updated Text"});
    print("✅ 스토리스크립트 업데이트 완료");
  }

  // 스토리스크립트 삭제 테스트
  Future<void> deleteStoryScriptTest() async {
    await storyRepository.deleteStoryScript(testStoryId, testScriptId);
    print("✅ 스토리스크립트 삭제 완료");
  }

  // 전체 테스트 실행 (성공)
  Future<void> runAllTests() async {
    await createStoryTest();
    // 10초 대기
    await Future.delayed(const Duration(seconds: 10));
    await readStoryTest();
    await Future.delayed(const Duration(seconds: 10));
    await updateStoryTest();
    await Future.delayed(const Duration(seconds: 10));
    await readStoryTest();
    await Future.delayed(const Duration(seconds: 10));
    await deleteStoryTest();
    await Future.delayed(const Duration(seconds: 10));
    await createStoryScriptTest();
    await Future.delayed(const Duration(seconds: 10));
    await readStoryScriptsTest();
    await Future.delayed(const Duration(seconds: 10));
    await updateStoryScriptTest();
    await Future.delayed(const Duration(seconds: 10));
    await readStoryScriptsTest();
    await Future.delayed(const Duration(seconds: 10));
    await deleteStoryScriptTest();
  }
}
