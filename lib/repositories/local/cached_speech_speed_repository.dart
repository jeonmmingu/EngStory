import 'package:eng_story/models/cache/cached_read_option.dart';
import 'package:eng_story/services/local/cache_services.dart';

class CachedSpeechSpeedRepository {
  final CacheService<CachedReadOption> _cacheService =
      CacheService<CachedReadOption>('read_option_cache');

  // ------------------- 📌 Create & Update -------------------
  /// 🔹 'read_option_cache' 박스에 speechSpeed 값 업데이트
  Future<void> saveSpeechSpeed(double speechSpeed) async {
    final cachedReadOption = CachedReadOption(speechSpeed: speechSpeed);
    await _cacheService.saveItem('cachedReadOption', cachedReadOption);
  }

  // ------------------- 📌 Read -------------------
  /// 🔹 'read_option_cache' 박스에서 speechSpeed 값 가져오기
  Future<double> getSpeechSpeed() async {
    final cachedReadOption =
        await _cacheService.getItemByKey('cachedReadOption');
    return cachedReadOption?.speechSpeed ?? 0.5;
  }
}
