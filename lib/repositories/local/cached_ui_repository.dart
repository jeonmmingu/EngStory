import 'package:eng_story/core/enums/theme_color.dart';
import 'package:eng_story/models/cache/cached_ui_meta.dart';
import 'package:eng_story/services/local/cache_services.dart';

class CachedUIRepository {
  final CacheService<CachedUIMeta> _cacheService =
      CacheService<CachedUIMeta>('ui_cache');

  // ------------------- 📌 Create & Update -------------------
  /// 🔹 'ui_cache' 박스에 themeColor 값 업데이트
  Future<void> saveThemeColor(ThemeColor themeColor) async {
    final cachedUIMeta = CachedUIMeta(themeColor: themeColor.name);
    await _cacheService.saveItem('cachedUIMeta', cachedUIMeta);
  }

  // ------------------- 📌 Read -------------------
  /// 🔹 'ui_cache' 박스에서 themeColor 값 가져오기
  Future<ThemeColor> getThemeColor() async {
    final cachedUIMeta = await _cacheService.getItemByKey('cachedUIMeta');
    return cachedUIMeta?.themeColor == null
        ? ThemeColor.BlueThemeColors
        : stringToThemeColor(cachedUIMeta!.themeColor);
  }
}
