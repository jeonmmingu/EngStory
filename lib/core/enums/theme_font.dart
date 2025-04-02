// ignore_for_file: constant_identifier_names

enum ThemeFont {
  eunbyeol,
  GowunDodum,
  Pretendard,
  SejongGeulggot,
  Yeongdo,
}

// string to enum
ThemeFont stringToThemeFont(String themeFont) {
  switch (themeFont) {
    case 'eunbyeol':
      return ThemeFont.eunbyeol;
    case 'GowunDodum':
      return ThemeFont.GowunDodum;
    case 'Pretendard':
      return ThemeFont.Pretendard;
    case 'SejongGeulggot':
      return ThemeFont.SejongGeulggot;
    case 'Yeongdo':
      return ThemeFont.Yeongdo;
    default:
      return ThemeFont.SejongGeulggot;
  }
}
