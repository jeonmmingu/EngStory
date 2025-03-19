import 'package:eng_story/models/cache/cached_story_script.dart';
import 'package:eng_story/models/story_script.dart';
import 'package:eng_story/services/local/cache_services.dart';

class CachedStoryScriptRepository {
  final CacheService<CachedStoryScript> _cacheService =
      CacheService<CachedStoryScript>('story_scripts_cache');

  // ------------------- 📌 Create & Update -------------------

  /// 🔹 스토리 스크립트 저장 (Create & Update)
  Future<void> saveScript(StoryScript script) async {
    await _cacheService.saveItem(
      script.id,
      CachedStoryScript.fromStoryScript(script),
    );
  }

  /// 🔹 여러 스토리 스크립트 저장 (Create & Update)
  Future<void> saveScripts(List<StoryScript> scripts) async {
    for (var script in scripts) {
      await saveScript(script);
    }
  }

  // ------------------- 📌 Read -------------------

  /// 🔹 특정 스토리의 모든 스크립트 가져오기 (Read by storyId)
  Future<List<CachedStoryScript>> getScriptsByStoryId(String storyId) async {
    final allScripts = await _cacheService.getAllItems();
    return allScripts.where((script) => script.storyId == storyId).toList();
  }

  // ------------------- 📌 Delete -------------------

  /// 🔹 특정 스크립트 삭제 (Delete by scriptId)
  Future<void> deleteScript(String scriptId) async {
    await _cacheService.deleteItem(scriptId);
  }

  /// 🔹 특정 스토리의 모든 스크립트 삭제 (Delete by storyId)
  Future<void> deleteScriptsByStoryId(String storyId) async {
    final scripts = await getScriptsByStoryId(storyId);
    for (var script in scripts) {
      await _cacheService.deleteItem(script.id);
    }
  }

  /// 🔹 전체 캐시 삭제 (Clear All)
  Future<void> clearCache() async {
    await _cacheService.clearCache();
  }
}
