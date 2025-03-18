import 'package:eng_story/core/enums/story_time.dart';
import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/cache/cached_story.dart';
import 'package:eng_story/repositories/local/cached_story_repository.dart';
import 'package:eng_story/repositories/remote/story_repository.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeViewModel with ChangeNotifier {
  final CachedStoryRepository _cacheRepository = CachedStoryRepository();
  final StoryRepository _storyRepository = StoryRepository();

  // 📌 스토리 읽기 시간 설정 (기본값: short)
  StoryTime _storyTime = StoryTime.short;
  StoryTime get storyTime => _storyTime;

  // 📌 현재 선택된 스토리
  Story? _selectedStory;
  Story? get selectedStory => _selectedStory;

  // 📌 캐싱된 스토리 목록
  List<CachedStory> _cachedStories = [];
  List<CachedStory> get cachedStories => _cachedStories;

  // 📌 스토리 읽기 과정
  String _initializeProgress = "cache"; // cache -> sync
  String get initializeProgress => _initializeProgress;

  /// 🔹 앱 실행 시 초기화 작업 수행
  Future<void> initializeApp() async {
    try {
      // 1️⃣ 1초 딜레이 후 캐싱된 데이터 불러오기
      await Future.delayed(const Duration(milliseconds: 1300));
      await _loadCachedStories();
      setInitializeProgress("sync");

      // 2️⃣ Firestore에서 최신 데이터 동기화
      await _syncStories();

      // 3️⃣ 1초 딜레이 후 완료
      await Future.delayed(const Duration(milliseconds: 1300));

      debugPrint("✅ 앱 초기화 완료!");
    } catch (e) {
      debugPrint("❌ 앱 초기화 실패: $e");
    }
  }

  void setInitializeProgress(String progress) {
    _initializeProgress = progress;
    notifyListeners();
  }

  /// 🔹 스토리 읽기 시간 설정
  void setStoryTime(StoryTime storyTime) {
    _storyTime = storyTime;
    notifyListeners();
  }

  /// 🔹 선택된 스토리 설정
  void setSelectedStory(Story story) {
    _selectedStory = story;
    notifyListeners();
  }

  /// 🔹 캐싱된 스토리 불러오기 (한 번만 실행)
  Future<void> _loadCachedStories() async {
    try {
      _cachedStories = await _cacheRepository.getAllStories();
      debugPrint("🗂 캐싱된 스토리 개수: ${_cachedStories.length}");
    } catch (e) {
      debugPrint("⚠ 캐싱된 스토리 불러오기 실패: $e");
    }
  }

  /// 🔹 Firestore에서 최신 스토리 가져와 동기화
  Future<void> _syncStories() async {
    try {
      final lastUpdated = _getLastUpdatedAt();
      final newStories = await _storyRepository.readFilteredStories(
        field: 'updatedAt',
        value: Timestamp.fromDate(
          lastUpdated.toDate().add(const Duration(seconds: 10)),
        ),
        condition: "isGreaterThan",
      );

      if (newStories.isNotEmpty) {
        for (var story in newStories) {
          debugPrint("📥 Firestore 스토리 동기화: ${story.title}");
          CachedStory cachedStory = CachedStory.fromStory(story);
          await _cacheRepository.saveStory(cachedStory);
          _cachedStories.add(cachedStory); // 🔹 동기화된 데이터 바로 리스트에 추가
        }
        notifyListeners(); // 🔹 UI 업데이트
      }

      debugPrint("✅ Firestore 스토리 동기화 완료!");
    } catch (e) {
      debugPrint("❌ Firestore 동기화 실패: $e");
    }
  }

  /// 🔹 가장 최신 업데이트된 `updatedAt` 찾기
  Timestamp _getLastUpdatedAt() {
    if (_cachedStories.isEmpty) return Timestamp(0, 0);
    return Timestamp.fromDate(
      _cachedStories
          .map((story) => story.updatedAt)
          .reduce((a, b) => a.isAfter(b) ? a : b),
    );
  }

  /// 🔹 특정 스토리의 `lastReadScriptIndex` 업데이트
  Future<void> updateLastReadScriptIndex(String storyId, int newIndex) async {
    try {
      await _cacheRepository.updateLastReadScriptIndex(storyId, newIndex);
      debugPrint("✅ lastReadScriptIndex 업데이트 완료!");
    } catch (e) {
      debugPrint("❌ lastReadScriptIndex 업데이트 실패: $e");
    }
  }
}
