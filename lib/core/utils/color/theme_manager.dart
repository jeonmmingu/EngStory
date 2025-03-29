import 'package:eng_story/core/enums/theme_color.dart';
import 'package:eng_story/core/utils/color/app_colors.dart';
import 'package:eng_story/repositories/local/cached_ui_repository.dart';

class ThemeManager {
  ThemeManager._privateConstructor();
  static final ThemeManager _instance = ThemeManager._privateConstructor();
  factory ThemeManager() => _instance;

  final CachedUIRepository _cachedUIRepository = CachedUIRepository();

  static AppColors current = BlueThemeColors();

  Future<void> setTheme(ThemeColor theme) async {
    await _cachedUIRepository.saveThemeColor(theme);
    current = getThemeColorFromEnum(theme);
  }

  Future<void> initializeTheme() async {
    current = getThemeColorFromEnum(await _cachedUIRepository.getThemeColor());
  }

  // 전체 color Theme 개수 반환
  int getThemeCount() {
    return ThemeColor.values.length;
  }

  // 전체 color Theme 리스트 반환
  List<ThemeColor> getAllThemeColors() {
    return [
      ThemeColor.BlueThemeColors,
      ThemeColor.GreenThemeColors,
      ThemeColor.YellowThemeColors,
      ThemeColor.RedThemeColors,
      ThemeColor.PinkThemeColors,
      ThemeColor.PurpleThemeColors,
      ThemeColor.BrownThemeColors,
      ThemeColor.GreyThemeColors,
      ThemeColor.IvoryThemeColors,
    ];
  }

  // ThemeColor enum을 AppColors로 변환
  AppColors getThemeColorFromEnum(ThemeColor themeColor) {
    switch (themeColor) {
      case ThemeColor.BlueThemeColors:
        return BlueThemeColors();
      case ThemeColor.GreenThemeColors:
        return GreenThemeColors();
      case ThemeColor.YellowThemeColors:
        return YellowThemeColors();
      case ThemeColor.RedThemeColors:
        return RedThemeColors();
      case ThemeColor.PinkThemeColors:
        return PinkThemeColors();
      case ThemeColor.PurpleThemeColors:
        return PurpleThemeColors();
      case ThemeColor.BrownThemeColors:
        return BrownThemeColors();
      case ThemeColor.GreyThemeColors:
        return GreyThemeColors();
      case ThemeColor.IvoryThemeColors:
        return IvoryThemeColors();
    }
  }
}
