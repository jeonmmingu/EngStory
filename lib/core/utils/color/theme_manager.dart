import 'package:eng_story/core/utils/color/app_colors.dart';

class ThemeManager {
  static AppColors current = BlueThemeColors();

  static void setTheme(AppColors theme) {
    current = theme;
  }
}
