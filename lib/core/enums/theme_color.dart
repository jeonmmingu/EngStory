// ignore_for_file: constant_identifier_names

enum ThemeColor {
  RedThemeColors,
  BlueThemeColors,
  GreenThemeColors,
  YellowThemeColors,
  PurpleThemeColors,
  PinkThemeColors,
  BrownThemeColors,
  GreyThemeColors,
  IvoryThemeColors,
}

// string to enum
ThemeColor stringToThemeColor(String themeColor) {
  switch (themeColor) {
    case 'RedThemeColors':
      return ThemeColor.RedThemeColors;
    case 'BlueThemeColors':
      return ThemeColor.BlueThemeColors;
    case 'GreenThemeColors':
      return ThemeColor.GreenThemeColors;
    case 'YellowThemeColors':
      return ThemeColor.YellowThemeColors;
    case 'PurpleThemeColors':
      return ThemeColor.PurpleThemeColors;
    case 'PinkThemeColors':
      return ThemeColor.PinkThemeColors;
    case 'BrownThemeColors':
      return ThemeColor.BrownThemeColors;
    case 'GreyThemeColors':
      return ThemeColor.GreyThemeColors;
    case 'IvoryThemeColors':
      return ThemeColor.IvoryThemeColors;
    default:
      return ThemeColor.GreyThemeColors;
  }
}
