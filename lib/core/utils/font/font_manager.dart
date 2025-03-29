import 'package:eng_story/core/enums/theme_font.dart';
import 'package:eng_story/core/utils/font/fonts.dart';
import 'package:eng_story/repositories/local/cached_font_repository.dart';

class FontManager {
  CachedFontRepository cachedFontRepository = CachedFontRepository();

  FontManager._privateConstructor();

  static final FontManager _instance = FontManager._privateConstructor();

  static AppTextStyles current = AppTextStyles('SejongGeulggot');

  factory FontManager() {
    return _instance;
  }

  // AppTextStyle 변경
  Future<void> setFont(String fontFamily) async {
    // 폰트 변경
    await cachedFontRepository.saveFontFamily(fontFamily);
    // 변경된 폰트 설정
    current = AppTextStyles(fontFamily);
  }

  // Font 초기화
  Future<void> initializeFont() async {
    // 저장된 폰트 가져오기
    String fontFamily = await cachedFontRepository.getFontFamily();
    // 기본 폰트 설정
    current = AppTextStyles(fontFamily);
  }

  // 전체 Font 개수 반환
  int getFontCount() {
    return ThemeFont.values.length;
  }

  // 전체 Font 이름 반환
  List<ThemeFont> getFontNames() {
    return [
      ThemeFont.GowunDodum,
      ThemeFont.SejongGeulggot,
      ThemeFont.Pretendard,
      ThemeFont.Yeongdo,
      ThemeFont.eunbyeol,
    ];
  }

  // ThemeFont string 한글 이름 반환
  String getFontName(String font) {
    switch (font) {
      case 'GowunDodum':
        return '고운돋움체';
      case 'SejongGeulggot':
        return '세종글꽃체';
      case 'Pretendard':
        return '프리텐다드';
      case 'Yeongdo':
        return '영도체';
      case 'eunbyeol':
        return '은별체';
      default:
        return '';
    }
  }
}
