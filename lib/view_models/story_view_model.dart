import 'package:eng_story/models/story_script.dart';
import 'package:eng_story/repositories/local/cached_story_script_repository.dart';
import 'package:eng_story/repositories/remote/story_repository.dart';
import 'package:flutter/material.dart';

/// 📌 StoryViewModel
class StoryViewModel with ChangeNotifier {
  final StoryRepository _storyRepository = StoryRepository();
  final CachedStoryScriptRepository _cachedStoryScriptRepository =
      CachedStoryScriptRepository();

  // 📌 선택된 스토리의 전체 스크립트 리스트
  final List<StoryScript> _selectedScripts = [];
  List<StoryScript> get selectedScripts => _selectedScripts;

  // 📌 현재 진행 중인 스크립트 인덱스
  int _currentIdx = 0;
  int get currentIdx => _currentIdx;

  // 📌 화면에 표시되는 스크립트 리스트 (스토리텔러)
  final List<StoryScript> _storyTellerScripts = [];
  List<StoryScript> get storyTellerScripts => _storyTellerScripts;

  // 📌 화면에 표시되는 스크립트 리스트 (사용자)
  final List<StoryScript> _meScripts = [];
  List<StoryScript> get meScripts => _meScripts;

  // 📌 현재 언어 모드 (영어 / 한국어)
  String languageMode = "Eng";

  /// 🔹 초기 설정 (index 기준)
  void init(int idx) {
    print("🔹 Script Length: (${selectedScripts.length})");
    print("🔹 StoryViewModel.init($idx)");
    if (idx == 0) return; // 초기화할 스크립트가 없을 경우
    _currentIdx = idx;

    final script = getScript(idx);
    if (script.role == "story_teller") {
      var tmpIdx = idx;
      while (tmpIdx > 0 && getScript(tmpIdx).role == "story_teller") {
        addStoryTellerScript(getScript(tmpIdx));
        tmpIdx--;
      }
    } else {
      addMeScript(script);
      var tmpIdx = idx - 1;
      while (tmpIdx > 0 && getScript(tmpIdx).role == "story_teller") {
        addStoryTellerScript(getScript(tmpIdx));
        tmpIdx--;
      }
    }
    storyTellerScripts.sort((a, b) => a.index.compareTo(b.index));
  }

  /// 🔹 언어 모드 변경 (Eng ↔ Kor)
  void changeLanguageMode() {
    languageMode = languageMode == "Eng" ? "Kor" : "Eng";
    notifyListeners();
  }

  /// 🔹 스토리 스크립트 불러오기
  /// - Cache에 저장된 스크립트가 있는 경우, Cache에서 불러오기
  /// - Cache에 저장된 스크립트가 없는 경우, Firestore에서 불러오기
  Future<bool> getScripts(String storyId) async {
    // Cache에서 스토리 스크립트 불러오기 시도
    final isCached = await _loadScriptsFromCache(storyId);
    // Cache에 없는 경우 Firestore에서 불러오기
    if (!isCached) {
      debugPrint("✅ Firestore에서 스토리 스크립트 불러옴");
      return await _loadScriptsFromFirestore(storyId);
    } else {
      debugPrint("✅ Cache에서 스토리 스크립트 불러옴");
      return true;
    }
  }

  /// 🔹 Cache에서 스토리 스크립트 불러오기
  Future<bool> _loadScriptsFromCache(String storyId) async {
    resetAllStates(); // 기존 상태 초기화
    final scripts =
        await _cachedStoryScriptRepository.getScriptsByStoryId(storyId);
    _selectedScripts.addAll(scripts.map((e) => e.toStoryScript()).toList());
    return scripts.isNotEmpty;
  }

  /// 🔹 Firestore에서 스토리 스크립트 불러오기
  Future<bool> _loadScriptsFromFirestore(String storyId) async {
    try {
      resetAllStates(); // 기존 상태 초기화
      final scripts = await _storyRepository.readAllStoryScripts(storyId);
      _selectedScripts.addAll(scripts);
      // Cache에 새로 불러온 스크립트 저장
      await _cachedStoryScriptRepository.saveScripts(scripts);
      return true;
    } catch (err) {
      Exception("스토리 스크립트 가져오기 실패: $err");
      return false;
    }
  }

  /// 🔹 스토리 재생 (다음 스크립트)
  void playStory() {
    if (_currentIdx >= _selectedScripts.length) return;

    // 이전 스크립트가 사용자(me)였을 경우, 기존 대화 삭제
    if (_currentIdx != 0 && getScript(_currentIdx).role == "me") {
      clearMeScripts();
      clearStoryTellerScripts();
    }

    // 다음 스크립트 추가
    _currentIdx++;
    final script = getScript(_currentIdx);

    if (script.role == "story_teller") {
      addStoryTellerScript(script);
    } else {
      addMeScript(script);
    }

    notifyListeners();
  }

  /// 🔹 스토리 되감기 (이전 스크립트)
  void rewindStory() {
    if (_currentIdx == 0) return;

    if (getScript(_currentIdx).role == "me") {
      removeMeScript();
      _currentIdx--;
    } else {
      if (_storyTellerScripts.length != 1 || _currentIdx == 1) {
        removeStoryTellerScript();
        _currentIdx--;
      } else {
        removeStoryTellerScript();
        _currentIdx--;
        addMeScript(getScript(_currentIdx));

        // 이전 스크립트가 story_teller일 경우, 연속된 대화를 복원
        var tmpIdx = _currentIdx - 1;
        while (tmpIdx > 0 && getScript(tmpIdx).role == "story_teller") {
          addStoryTellerScript(getScript(tmpIdx));
          tmpIdx--;
        }

        // 스크립트 정렬
        _storyTellerScripts.sort((a, b) => a.index.compareTo(b.index));
      }
    }

    notifyListeners();
  }

  /// 🔹 현재 인덱스의 스크립트 반환
  StoryScript getScript(int idx) {
    return _selectedScripts.firstWhere((element) => element.index == idx);
  }

  /// 🔹 스토리텔러 스크립트 추가
  void addStoryTellerScript(StoryScript script) {
    _storyTellerScripts.add(script);
  }

  /// 🔹 스토리텔러 스크립트 제거 (마지막 요소)
  void removeStoryTellerScript() {
    _storyTellerScripts.removeLast();
  }

  /// 🔹 스토리텔러 스크립트 초기화
  void clearStoryTellerScripts() {
    _storyTellerScripts.clear();
  }

  /// 🔹 사용자 스크립트 추가
  void addMeScript(StoryScript script) {
    _meScripts.add(script);
  }

  /// 🔹 사용자 스크립트 제거 (마지막 요소)
  void removeMeScript() {
    _meScripts.removeLast();
  }

  /// 🔹 사용자 스크립트 초기화
  void clearMeScripts() {
    _meScripts.clear();
  }

  /// 🔹 모든 상태 초기화 (스토리 변경 시)
  void resetAllStates() {
    _selectedScripts.clear();
    _currentIdx = 0;
    languageMode = "Eng";
    clearStoryTellerScripts();
    clearMeScripts();
  }
}
