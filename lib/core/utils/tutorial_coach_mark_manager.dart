import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/font/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialCoachMarkManager {
  static final TutorialCoachMarkManager _instance =
      TutorialCoachMarkManager._internal();

  factory TutorialCoachMarkManager() {
    return _instance;
  }

  TutorialCoachMarkManager._internal();

  // 각 버튼에 대한 GlobalKey 정의
  final GlobalKey themeButtonKey = GlobalKey();
  final GlobalKey fontButtonKey = GlobalKey();
  final GlobalKey levelButtonKey = GlobalKey();
  final GlobalKey categoryButtonKey = GlobalKey();
  final GlobalKey requiredTimeButtonKey = GlobalKey();

  final List<TargetFocus> targets = [];

  bool get isInitialized => targets.isNotEmpty;

  void initializeTargets() {
    if (isInitialized) return;
    targets.clear();
    targets.addAll(
      [
        TargetFocus(
          identify: "themeButton",
          keyTarget: themeButtonKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: Column(
                children: [
                  Text(
                    "여기에서 테마를 선택할 수 있어요.",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "원하는 테마를 선택해 보세요.",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "fontButton",
          keyTarget: fontButtonKey,
          contents: [
            TargetContent(
              child: Column(
                children: [
                  Text(
                    "폰트를 변경할 수 있어요.",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "원하는 폰트를 선택해 보세요.",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "levelButton",
          keyTarget: levelButtonKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: Column(
                children: [
                  Text(
                    "난이도를 선택해 주세요.",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "1~3단계로 나뉘어져 있어요.",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "categoryButton",
          keyTarget: categoryButtonKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: Column(
                children: [
                  Text(
                    "카테고리를 선택해 주세요.",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "다양한 카테고리가 준비되어 있습니다.",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "requiredTimeButton",
          keyTarget: requiredTimeButtonKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: Column(
                children: [
                  Text(
                    "이야기 읽기에 드는 예상 소요 시간 입니다.",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "원하는 시간을 선택해 보세요.",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showTutorial(BuildContext context) {
    TutorialCoachMark(
      targets: targets,
      colorShadow: ThemeManager.current.text_1,
      textStyleSkip: FontManager.current.font_16.copyWith(
        color: ThemeManager.current.white,
      ),
      textSkip: "건너뛰기",
      opacityShadow: 0.8,
      onFinish: () => print("튜토리얼 완료"),
      onClickTarget: (target) => HapticFeedback.heavyImpact(),
      focusAnimationDuration: const Duration(milliseconds: 450),
      unFocusAnimationDuration: const Duration(milliseconds: 450),
    ).show(context: context);
  }
}
