import 'package:eng_story/models/cache/cached_sync_meta.dart';
import 'package:eng_story/services/local/cache_services.dart';

class CachedSyncRepository {
  final CacheService<CachedSyncMeta> _cacheService =
      CacheService<CachedSyncMeta>('sync_cache');

  // ------------------- 📌 Create & Update -------------------
  /// 🔹 'sync_cache' 박스에 lastSyncedAt 값 업데이트
  Future<void> saveLastSyncedAt(DateTime lastSyncedAt) async {
    final cachedSyncMeta = CachedSyncMeta(lastSyncedAt: lastSyncedAt);
    await _cacheService.saveItem('cachedSyncMeta', cachedSyncMeta);
  }

  // ------------------- 📌 Read -------------------
  /// 🔹 'sync_cache' 박스에서 lastSyncedAt 값 가져오기
  Future<DateTime?> getLastSyncedAt() async {
    final cachedSyncMeta = await _cacheService.getItemByKey('cachedSyncMeta');
    return cachedSyncMeta?.lastSyncedAt;
  }
}
