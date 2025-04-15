import 'package:eng_story/models/cache/cached_font_meta.dart';
import 'package:eng_story/services/local/cache_services.dart';

class CachedFontRepository {
  final CacheService<CachedFontMeta> _cacheService =
      CacheService<CachedFontMeta>('font_cache');

  // ------------------- 📌 Create & Update -------------------
  /// 🔹 'font_cache' 박스에 fontFamily 값 업데이트
  Future<void> saveFontFamily(String fontFamily) async {
    final cachedFontMeta = CachedFontMeta(fontFamily: fontFamily);
    await _cacheService.saveItem('cachedFontMeta', cachedFontMeta);
  }

  // ------------------- 📌 Read -------------------
  /// 🔹 'font_cache' 박스에서 fontFamily 값 가져오기
  Future<String> getFontFamily() async {
    final cachedFontMeta = await _cacheService.getItemByKey('cachedFontMeta');
    return cachedFontMeta?.fontFamily ?? 'sejongGeulggot';
  }
}
