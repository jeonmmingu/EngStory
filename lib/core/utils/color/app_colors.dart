import 'package:flutter/material.dart';

/// MARK: - App Colors (Abstract Class)
abstract class AppColors {
  Color get white;
  Color get black;

  Color get grey_1;
  Color get grey_2;
  Color get grey_3;
  Color get grey_4;

  Color get background;

  Color get text_1;
  Color get text_2;

  Color get button;
}

/// MARK: - Blue Theme
class BlueThemeColors extends AppColors {
  @override
  Color get white => const Color(0xFFFFFFFF);
  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get grey_1 => const Color(0xFFC9E3F2);
  @override
  Color get grey_2 => const Color(0xFFA1C4DE);
  @override
  Color get grey_3 => const Color(0xFF6CA4C9);
  @override
  Color get grey_4 => const Color(0xFF396B91);

  @override
  Color get background => const Color(0xFFEAF4FC);

  @override
  Color get text_1 => const Color(0xFF2B5D9A);
  @override
  Color get text_2 => const Color(0xFF4F81BD);

  @override
  Color get button => const Color(0xFF85B1D1);
}

/// MARK: - Green Theme
class GreenThemeColors extends AppColors {
  @override
  Color get white => const Color(0xFFFFFFFF);
  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get grey_1 => const Color(0xFFCFE6D9);
  @override
  Color get grey_2 => const Color(0xFFA9C9B7);
  @override
  Color get grey_3 => const Color(0xFF78AD91);
  @override
  Color get grey_4 => const Color(0xFF3D6A5A);

  @override
  Color get background => const Color(0xFFE9F8EF);

  @override
  Color get text_1 => const Color(0xFF1B4332);
  @override
  Color get text_2 => const Color(0xFF52796F);

  @override
  Color get button => const Color(0xFF9BC9AF);
}

/// MARK: - Pink Theme
class PinkThemeColors extends AppColors {
  @override
  Color get white => const Color(0xFFFFFFFF);
  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get grey_1 => const Color(0xFFF4C6CE);
  @override
  Color get grey_2 => const Color(0xFFD9A9B4);
  @override
  Color get grey_3 => const Color(0xFFBF5F7A);
  @override
  Color get grey_4 => const Color(0xFF893C50);

  @override
  Color get background => const Color(0xFFFFF1F4);

  @override
  Color get text_1 => const Color(0xFF6B2737);
  @override
  Color get text_2 => const Color(0xFFAD5D73);

  @override
  Color get button => const Color(0xFFF8A8BA);
}

/// MARK: - Brown Theme
class BrownThemeColors extends AppColors {
  @override
  Color get white => const Color(0xFFFFFFFF);
  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get grey_1 => const Color(0xFFF3EDE8);
  @override
  Color get grey_2 => const Color(0xFFD8C4B6);
  @override
  Color get grey_3 => const Color(0xFFB59787);
  @override
  Color get grey_4 => const Color(0xFF7B5E4A);

  @override
  Color get background => const Color(0xFFFAF4EF);

  @override
  Color get text_1 => const Color(0xFF4E342E);
  @override
  Color get text_2 => const Color(0xFF7B5E4A);

  @override
  Color get button => const Color(0xFFC9A88D);
}

/// MARK: - Yellow Theme
class YellowThemeColors extends AppColors {
  @override
  Color get white => const Color(0xFFFFFFFF);
  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get grey_1 => const Color(0xFFF5D87A);
  @override
  Color get grey_2 => const Color(0xFFE2B84C);
  @override
  Color get grey_3 => const Color(0xFFC99C23);
  @override
  Color get grey_4 => const Color(0xFF8C6B10);

  @override
  Color get background => const Color(0xFFFFFBEA);

  @override
  Color get text_1 => const Color(0xFF8B6C00);
  @override
  Color get text_2 => const Color(0xFFB99328);

  @override
  Color get button => const Color(0xFFEFD27D);
}

/// MARK: - Grey Theme
class GreyThemeColors extends AppColors {
  @override
  Color get white => const Color(0xFFFFFFFF);
  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get grey_1 => const Color(0xFFE0E0E0);
  @override
  Color get grey_2 => const Color(0xFFBDBDBD);
  @override
  Color get grey_3 => const Color(0xFF828282);
  @override
  Color get grey_4 => const Color(0xFF4F4F4F);

  @override
  Color get background => const Color(0xFFF7F7F7);

  @override
  Color get text_1 => const Color(0xFF333333);
  @override
  Color get text_2 => const Color(0xFF4F4F4F);

  @override
  Color get button => const Color(0xFFB0B0B0);
}

/// MARK: - Purple Theme
class PurpleThemeColors extends AppColors {
  @override
  Color get white => const Color(0xFFFFFFFF);
  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get grey_1 => const Color(0xFFD9CFE6);
  @override
  Color get grey_2 => const Color(0xFFBFA6D6);
  @override
  Color get grey_3 => const Color(0xFF936CB5);
  @override
  Color get grey_4 => const Color(0xFF5D3E7A);

  @override
  Color get background => const Color(0xFFF2EDF7);

  @override
  Color get text_1 => const Color(0xFF3E2854);
  @override
  Color get text_2 => const Color(0xFF5D3E7A);

  @override
  Color get button => const Color(0xFFB89FCC);
}

/// MARK: - Red Theme
class RedThemeColors extends AppColors {
  @override
  Color get white => const Color(0xFFFFFFFF);
  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get grey_1 => const Color(0xFFF3D6D6);
  @override
  Color get grey_2 => const Color(0xFFE2AFAF);
  @override
  Color get grey_3 => const Color(0xFFCC6E6E);
  @override
  Color get grey_4 => const Color(0xFF933636);

  @override
  Color get background => const Color(0xFFFFF1F1);

  @override
  Color get text_1 => const Color(0xFF6B1E1E);
  @override
  Color get text_2 => const Color(0xFF933636);

  @override
  Color get button => const Color(0xFFE6A5A5);
}

/// MARK: - Paper Theme
class IvoryThemeColors extends AppColors {
  @override
  Color get white => const Color(0xFFFFFFFF);
  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get grey_1 => const Color(0xFFF3EEE7); // 아주 연한 아이보리 (border)
  @override
  Color get grey_2 => const Color(0xFFE0D8CC); // 종이톤 베이지 (disabled)
  @override
  Color get grey_3 => const Color(0xFFBAA891); // 연갈색 (강조)
  @override
  Color get grey_4 => const Color(0xFF7C6B58); // 짙은 브라운 (서브 텍스트)

  @override
  Color get background => const Color(0xFFFAF5EF); // 전체 종이 배경색

  @override
  Color get text_1 => const Color(0xFF4B3F2F); // 본문 텍스트 (짙은 브라운)
  @override
  Color get text_2 => const Color(0xFF7C6B58); // 서브 텍스트

  @override
  Color get button => const Color(0xFFD6C3A3); // 연한 갈색 버튼
}
