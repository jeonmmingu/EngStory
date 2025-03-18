import 'package:eng_story/models/cache/cached_story.dart';
import 'package:eng_story/services/local/cache_services.dart';

class CachedStoryRepository {
  final CacheService<CachedStory> _cacheService =
      CacheService<CachedStory>('stories_cache');

  // ------------------- 📌 Create & Update -------------------

  /// 🔹 **스토리 저장 (Create & Update)**
  Future<void> saveStory(CachedStory story) async {
    await _cacheService.saveItem(story.id, story);
  }

  // ------------------- 📌 Read -------------------

  /// 🔹 **모든 스토리 가져오기 (Read All)**
  Future<List<CachedStory>> getAllStories() async {
    return await _cacheService.getAllItems();
  }

  /// 🔹 **특정 스토리 가져오기 (Read)**
  Future<CachedStory?> getStoryById(String storyId) async {
    return await _cacheService.getItemByKey(storyId);
  }

  /// 🔹 **읽기 시간 기준으로 스토리 필터링 (Read with Filter)**
  Future<List<CachedStory>> getStoriesByReadTime(String readTime) async {
    final allStories = await _cacheService.getAllItems();
    return allStories.where((story) => story.readTime == readTime).toList();
  }

  // ------------------- 📌 Update -------------------

  /// 🔹 **특정 `storyId`의 `lastReadScriptIndex`만 업데이트 (Partial Update)**
  Future<void> updateLastReadScriptIndex(String storyId, int newIndex) async {
    final story = await getStoryById(storyId);
    if (story != null) {
      story.lastReadScriptIndex = newIndex;
      await saveStory(story);
    }
  }

  // ------------------- 📌 Delete -------------------

  /// 🔹 **스토리 삭제 (Delete)**
  Future<void> deleteStory(String storyId) async {
    await _cacheService.deleteItem(storyId);
  }

  /// 🔹 **전체 캐시 삭제 (Clear All)**
  Future<void> clearCache() async {
    await _cacheService.clearCache();
  }
}
