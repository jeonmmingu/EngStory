import 'package:eng_story/core/utils/tts_manager.dart';
import 'package:eng_story/models/story_script.dart';
import 'package:eng_story/repositories/local/cached_story_repository.dart';
import 'package:eng_story/repositories/local/cached_story_script_repository.dart';
import 'package:eng_story/repositories/remote/story_repository.dart';
import 'package:flutter/material.dart';

/// 📌 StoryViewModel
class StoryViewModel with ChangeNotifier {
  final StoryRepository _storyRepository = StoryRepository();
  final CachedStoryScriptRepository _cachedStoryScriptRepository =
      CachedStoryScriptRepository();
  final _cacheStoryRepository = CachedStoryRepository();

  // StoryViewModel에 추가
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

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

  // 📌 이야기 스크롤 컨트롤러
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  // 📌 자동 진행 변수
  bool _isAutoPlaying = false;
  bool get isAutoPlaying => _isAutoPlaying;
  bool _autoPlayCancelled = false;
  bool get autoPlayCancelled => _autoPlayCancelled;

  /// 🔹 초기 설정 (index 기준)
  void init(int idx) {
    print("🔹 Script Length: (${selectedScripts.length})");
    print("🔹 StoryViewModel.init($idx)");

    if (idx == 0) return;
    _currentIdx = idx;

    for (int i = 1; i <= idx; i++) {
      final script = getScript(i);
      if (script.role == "story_teller") {
        addStoryTellerScript(script);
      } else {
        addMeScript(script);
      }
    }
    storyTellerScripts.sort((a, b) => a.index.compareTo(b.index));

    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      },
    );
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
    debugPrint("🔹 playStory($currentIdx/${_selectedScripts.length})");

    if (_currentIdx >= _selectedScripts.length - 1) return;

    _currentIdx++;
    final script = getScript(_currentIdx);

    if (script.role == "story_teller") {
      addStoryTellerScript(script);
    } else {
      addMeScript(script);
    }

    listKey.currentState?.insertItem(
      _storyTellerScripts.length + _meScripts.length - 1,
      duration: const Duration(milliseconds: 600),
    );

    Future.delayed(const Duration(milliseconds: 50), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });

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

  /// 🔹 읽은 스토리를 0번 index로 초기화
  void resetStoryScripts() {
    _currentIdx = 0;
    clearStoryTellerScripts();
    clearMeScripts();
    notifyListeners();
  }

  /// 🔹 AutoPlay 상태 변경
  void toggleAutoPlay() {
    _isAutoPlaying = !_isAutoPlaying;
    notifyListeners();
  }

  Future<void> startAutoPlay(String storyId) async {
    _autoPlayCancelled = false;

    while (_currentIdx < _selectedScripts.length - 1 && !_autoPlayCancelled) {
      playStory();

      await _cacheStoryRepository.updateLastReadScriptIndex(
        storyId,
        _currentIdx,
      );

      await TtsManager().flutterTts.stop();
      await TtsManager().flutterTts.awaitSpeakCompletion(true);
      // TTS 시작
      await TtsManager().flutterTts.speak(getScript(_currentIdx).text_en);
      await TtsManager().flutterTts.awaitSpeakCompletion(false);

      // TTS 끝나고 0.6초 대기
      if (_autoPlayCancelled) break;
      await Future.delayed(const Duration(milliseconds: 750));
    }

    _isAutoPlaying = false;
    notifyListeners();
  }

  Future<void> cancelAutoPlay() async {
    _autoPlayCancelled = true;
    _isAutoPlaying = false;
    await TtsManager().flutterTts.stop();
    await TtsManager().flutterTts.awaitSpeakCompletion(false);
    notifyListeners();
  }

  /// 🔹 모든 상태 초기화 (스토리 변경 시)
  void resetAllStates() {
    _selectedScripts.clear();
    _currentIdx = 0;
    languageMode = "Eng";
    _isAutoPlaying = false;
    clearStoryTellerScripts();
    clearMeScripts();
  }
}
