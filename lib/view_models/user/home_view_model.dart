import 'package:eng_story/core/enums/story_category.dart';
import 'package:eng_story/core/enums/story_time.dart';
import 'package:eng_story/core/utils/tutorial_coach_mark_manager.dart';
import 'package:eng_story/models/cache/cached_story.dart';
import 'package:eng_story/repositories/local/cached_speech_speed_repository.dart';
import 'package:eng_story/repositories/local/cached_story_repository.dart';
import 'package:eng_story/repositories/local/cached_sync_repository.dart';
import 'package:eng_story/repositories/remote/story_repository.dart';
import 'package:eng_story/services/remote/admob_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeViewModel with ChangeNotifier {
  final CachedStoryRepository _cacheStoryRepository = CachedStoryRepository();
  final CachedSyncRepository _cacheSyncRepository = CachedSyncRepository();
  final StoryRepository _storyRepository = StoryRepository();
  final CachedSpeechSpeedRepository _cachedSpeechSpeedRepository =
      CachedSpeechSpeedRepository();

  // 📌 스토리 읽기 시간 설정
  StoryTime? _storyTime;
  StoryTime? get storyTime => _storyTime;

  // 📌 카테고리 설정
  StoryCategory? _storyCategory;
  StoryCategory? get storyCategory => _storyCategory;

  // 📌 스토리 레벨 설정
  int? _storyLevel;
  int? get storyLevel => _storyLevel;

  // 📌 필터링 된 스토리 리스트
  List<CachedStory>? _filteredStories;
  List<CachedStory>? get filteredStories => _filteredStories;

  // 📌 필터링 된 스토리 리스트 index
  int _filteredStoryIndex = 0;
  int get filteredStoryIndex => _filteredStoryIndex;

  // 📌 card page view controller
  PageController? _pageController;
  PageController? get pageController => _pageController;

  // 📌 현재 선택된 스토리
  CachedStory? _selectedStory;
  CachedStory? get selectedStory => _selectedStory;

  // 📌 캐싱된 스토리 목록
  List<CachedStory> _cachedStories = [];
  List<CachedStory> get cachedStories => _cachedStories;

  // 📌 스토리 읽기 과정
  String _initializeProgress = "cache"; // cache -> sync
  String get initializeProgress => _initializeProgress;

  // 📌 삭제 로딩 인디케이터
  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;

  // 📌 선택된 Theme Color index
  int _selectedThemeColorIndex = 0;
  int get selectedThemeColorIndex => _selectedThemeColorIndex;

  // 📌 선택된 Theme font index
  int _selectedThemeFontIndex = 0;
  int get selectedThemeFontIndex => _selectedThemeFontIndex;

  // 📌 선택된 Speech Speed
  double _selectedSpeechSpeed = 0.5;
  double get selectedSpeechSpeed => _selectedSpeechSpeed;

  // 📌 GoogleAds Banner Ad
  BannerAd? _bannerAd;
  BannerAd? get bannerAd => _bannerAd;

  // 📌 GoogleAds interstitial Ad
  InterstitialAd? _interstitialAd;
  InterstitialAd? get interstitialAd => _interstitialAd;

  /// 🔹 앱 실행 시 초기화 작업 수행
  Future<void> initializeApp(bool isAdmin) async {
    try {
      if (!isAdmin) {
        TutorialCoachMarkManager().initializeTargets();
        await loadBannerAd();
        await createInterstitialAd();
      }

      // 1️⃣ 1초 딜레이 후 캐싱된 데이터 불러오기
      if (!isAdmin) {
        await Future.delayed(const Duration(milliseconds: 1300));
      }

      await _loadCachedStories();
      setInitializeProgress("sync");

      // 2️⃣ Firestore에서 최신 데이터 동기화
      await _syncStories();

      // 3️⃣ 1초 딜레이 후 완료
      if (!isAdmin) {
        await Future.delayed(const Duration(milliseconds: 1300));
      }

      debugPrint("✅ 앱 초기화 완료!");
    } catch (e) {
      debugPrint("❌ 앱 초기화 실패: $e");
    }
  }

  /// 🔹 GoogleAds 배너 광고 로드
  Future<void> loadBannerAd() async {
    _bannerAd = BannerAd(
      size: AdSize.fullBanner, //배너 사이즈
      adUnitId: AdMobService.bannerAdUnitId!, //광고ID 등록
      listener: AdMobService.bannerAdListener, //리스너 등록
      request: const AdRequest(),
    );

    await _bannerAd!.load(); //광고 로드
  }

  /// 🔹 GoogleAds 전면 광고 생성
  Future<void> createInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) => _interstitialAd = null,
      ),
    );
  }

  /// 🔹 GoogleAds 전면 광고 null로 설정
  void setInterstitialAdNull() {
    _interstitialAd = null;
    notifyListeners();
  }

  void setInitializeProgress(String progress) {
    _initializeProgress = progress;
    notifyListeners();
  }

  /// 🔹 스토리 읽기 시간 설정
  void setStoryTime(StoryTime? storyTime) {
    _storyTime = storyTime;
    setFilteredStories();
    if (pageController?.hasClients ?? false) {
      pageController!.jumpToPage(0);
    }
    notifyListeners();
  }

  /// 🔹 카테고리 설정
  void setStoryCategory(StoryCategory? category) {
    _storyCategory = category;
    setFilteredStories();
    if (pageController?.hasClients ?? false) {
      pageController!.jumpToPage(0);
    }
    notifyListeners();
  }

  /// 🔹 스토리 레벨 설정
  void setStoryLevel(int? level) {
    _storyLevel = level;
    setFilteredStories();
    if (pageController?.hasClients ?? false) {
      pageController!.jumpToPage(0);
    }
    notifyListeners();
  }

  /// 🔹 필터링된 스토리 인덱스 설정
  void setFilteredStoryIndex(int index) {
    _filteredStoryIndex = index;
    notifyListeners();
  }

  /// 🔹 PageController 설정
  void setPageController(PageController controller) {
    _pageController = controller;
  }

  /// 🔹 선택된 스토리 설정
  void setSelectedStory(CachedStory story) {
    _selectedStory = story;
  }

  /// 🔹 삭제 로딩 변수 설정
  void setIsDeleting(bool isDeleting) {
    _isDeleting = isDeleting;
    notifyListeners();
  }

  /// 🔹 선택된 테마 색상 인덱스 설정
  void setSelectedThemeColorIndex(int index) {
    _selectedThemeColorIndex = index;
    notifyListeners();
  }

  /// 🔹 선택된 테마 폰트 인덱스 설정
  void setSelectedThemeFontIndex(int index) {
    _selectedThemeFontIndex = index;
    notifyListeners();
  }

  /// 🔹 선택된 스피치 속도 설정
  Future<void> setSelectedSpeechSpeed() async {
    _selectedSpeechSpeed = await _cachedSpeechSpeedRepository.getSpeechSpeed();
    notifyListeners();
  }

  /// 🔹 스피치 속도 0.1 증가 or 감소 (add, minus 옵션)
  void changeSpeechSpeed(bool add) {
    if (add) {
      _selectedSpeechSpeed += 0.1;
    } else {
      _selectedSpeechSpeed -= 0.1;
    }
    if (_selectedSpeechSpeed == -0.0) {
      _selectedSpeechSpeed = 0.0;
    }
    notifyListeners();
  }

  /// 🔹 캐싱된 스토리 불러오기 (한 번만 실행)
  Future<void> _loadCachedStories() async {
    try {
      _cachedStories = await _cacheStoryRepository.getAllStories();
      debugPrint("🗂 캐싱된 스토리 개수: ${_cachedStories.length}");
    } catch (e) {
      debugPrint("⚠ 캐싱된 스토리 불러오기 실패: $e");
    }
  }

  /// 🔹 Firestore에서 새로운 이야기, 삭제된 이야기 동기화
  Future<void> _syncStories() async {
    try {
      // 새로운 이야기 & updated 된 이야기 동기화
      // 저장된 lastSyncedAt 값이 없으면 가장 오래전 시간으로 설정
      final lastUpdated = await _cacheSyncRepository.getLastSyncedAt() ??
          DateTime.fromMillisecondsSinceEpoch(0);

      debugPrint("lastUpdated: $lastUpdated");

      final newStories = await _storyRepository.readFilteredStories(
        field1: 'updatedAt',
        value1: Timestamp.fromDate(
          lastUpdated.add(const Duration(seconds: 10)),
        ),
        condition1: "isGreaterThan",
      );

      if (newStories.isNotEmpty) {
        for (var story in newStories) {
          debugPrint("📥 Firestore 스토리 동기화: ${story.title}");
          CachedStory cachedStory = CachedStory.fromStory(story);
          await _cacheStoryRepository.saveStory(cachedStory);
          _cachedStories.add(cachedStory); // 🔹 동기화된 데이터 바로 리스트에 추가
        }
      }

      // 삭제된 이야기 동기화
      final deletedStories =
          _cachedStories.where((cachedStory) => cachedStory.isDeleted).toList();

      debugPrint("삭제된 이야기 개수: ${deletedStories.length}");

      for (var deletedStory in deletedStories) {
        debugPrint("🗑 Firestore 스토리 삭제 동기화: ${deletedStory.title}");
        await _cacheStoryRepository.deleteStory(deletedStory.id);
        _cachedStories.remove(deletedStory);
      }

      // 동기화된 데이터가 있을 때만 lastSyncedAt 업데이트
      if (deletedStories.isNotEmpty || newStories.isNotEmpty) {
        await _cacheSyncRepository.saveLastSyncedAt(DateTime.now());
      }

      notifyListeners(); // 🔹 UI 업데이트

      debugPrint("✅ Firestore 스토리 동기화 완료!");
    } catch (e) {
      debugPrint("❌ Firestore 동기화 실패: $e");
    }
  }

  /// 🔹 storyTime, storyCategory, storyLevel 필터링 해서 story list 가져오기
  void setFilteredStories() {
    List<CachedStory> filteredStories = cachedStories;

    if (_storyTime != null) {
      filteredStories = filteredStories
          .where((story) => story.readTime == storyTime!.typeText)
          .toList();
    }

    if (_storyCategory != null) {
      filteredStories = filteredStories
          .where(
              (story) => story.category == displayCategoryText(_storyCategory!))
          .toList();
    }

    if (_storyLevel != null) {
      filteredStories = filteredStories
          .where((story) => story.storyLevel == storyLevel)
          .toList();
    }

    if (filteredStories.isEmpty ||
        (_storyTime == null && _storyCategory == null && _storyLevel == null)) {
      _filteredStories = null;
    } else {
      _filteredStories = filteredStories;
      _filteredStoryIndex = 1;
    }

    // 1. Cached Story의 lastReadScriptIndex 가 0인 것이 우선 오도록 정렬
    // 2. 그 다음은 updatedAt 기준 최신 순으로 정렬
    _filteredStories?.sort(
      (a, b) {
        if (a.lastReadScriptIndex == 0 && b.lastReadScriptIndex != 0) {
          return -1;
        } else if (a.lastReadScriptIndex != 0 && b.lastReadScriptIndex == 0) {
          return 1;
        } else {
          return b.updatedAt.compareTo(a.updatedAt);
        }
      },
    );
  }

  /// 🔹 storyTime 중 현재 선택 가능한 항목을 반환
  List<StoryTime> getAvailableStoryTimes() {
    return StoryTime.values
        .where(
          (time) => cachedStories.any((story) {
            return story.readTime == time.typeText &&
                ((story.storyLevel == storyLevel) || (storyLevel == null)) &&
                ((_storyCategory != null &&
                        story.category ==
                            displayCategoryText(_storyCategory)) ||
                    (_storyCategory == null));
          }),
        )
        .toList();
  }

  /// 🔹 storyCategory 중 현재 선택 가능한 항목을 반환
  List<StoryCategory> getAvailableStoryCategories() {
    return StoryCategory.values
        .where(
          (category) => cachedStories.any((story) {
            return story.category == displayCategoryText(category) &&
                ((story.storyLevel == storyLevel) || (storyLevel == null)) &&
                ((_storyTime == null) ||
                    (story.readTime == storyTime!.typeText));
          }),
        )
        .toList();
  }

  /// 🔹 storyLevel(1~4) 중 현재 선택 가능한 항목을 반환
  List<int> getAvailableStoryLevels() {
    return List.generate(4, (index) => index + 1)
        .where(
          (level) => cachedStories.any((story) {
            return story.storyLevel == level &&
                ((_storyTime == null) ||
                    (story.readTime == storyTime!.typeText)) &&
                ((_storyCategory == null) ||
                    (story.category == displayCategoryText(_storyCategory)));
          }),
        )
        .toList();
  }

  /// 🔹 특정 스토리의 `lastReadScriptIndex` 업데이트
  Future<void> updateLastReadScriptIndex(String storyId, int newIndex) async {
    try {
      await _cacheStoryRepository.updateLastReadScriptIndex(storyId, newIndex);
      debugPrint("✅ lastReadScriptIndex 업데이트 완료!");
      notifyListeners();
    } catch (e) {
      debugPrint("❌ lastReadScriptIndex 업데이트 실패: $e");
    }
  }

  /// 🔹 캐싱된 스토리 삭제하기
  Future<void> deleteCachedStory(String storyId) async {
    try {
      await _cacheStoryRepository.deleteStory(storyId);
      _cachedStories.removeWhere((story) => story.id == storyId);
      notifyListeners();
      debugPrint("✅ 캐싱된 스토리 삭제 완료!");
    } catch (e) {
      debugPrint("❌ 캐싱된 스토리 삭제 실패: $e");
    }
  }

  /// 🔹 notifying
  void notify() {
    notifyListeners();
  }
}
