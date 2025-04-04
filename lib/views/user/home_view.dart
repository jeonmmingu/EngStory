// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:eng_story/core/enums/story_category.dart';
import 'package:eng_story/core/enums/story_time.dart';
import 'package:eng_story/core/utils/animations.dart';
import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/font/font_manager.dart';
import 'package:eng_story/core/utils/font/fonts.dart';
import 'package:eng_story/models/cache/cached_story.dart';
import 'package:eng_story/services/local/device_info_manager.dart';
import 'package:eng_story/view_models/user/home_view_model.dart';
import 'package:eng_story/view_models/user/story_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// Home 화면
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // MARK: build
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<HomeViewModel>().initializeApp(false),
      builder: (context, snapshot) => Scaffold(
        backgroundColor: ThemeManager.current.background,
        body: _body(
          context,
          Provider.of<HomeViewModel>(context),
          snapshot.connectionState == ConnectionState.waiting,
        ),
      ),
    );
  }

  // MARK: - body
  Widget _body(
    BuildContext context,
    HomeViewModel homeViewModel,
    bool isLoading,
  ) {
    bool isAdmin = DeviceInfoManager().isAdmin();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: Platform.isAndroid ? 55.h : 70.h,
            right: 30.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MARK: - theme button
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  _showThemeSettingBottomModal(context);
                },
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.background,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Icon(
                    Icons.color_lens_outlined,
                    color: ThemeManager.current.grey_4,
                    size: 32.sp,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              // Font Change Button
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  _showFontSettingBottomModal(context);
                },
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.background,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Icon(
                    Icons.font_download_outlined,
                    color: ThemeManager.current.grey_4,
                    size: 32.sp,
                  ),
                ),
              ),
              if (isAdmin) ...[
                SizedBox(width: 20.w),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    DeviceInfoManager().isDeviceManagerChecked = false;
                    DeviceInfoManager().adminMode = true;
                    context.goNamed("adminView");
                  },
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ThemeManager.current.button,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Icon(
                      Icons.admin_panel_settings_outlined,
                      color: ThemeManager.current.white,
                      size: 32.sp,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
        SizedBox(height: isAdmin ? 62.h : 78.h),
        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간
            curve: Curves.easeOut, // 부드러운 움직임
            transform: Matrix4.translationValues(
              0,
              homeViewModel.filteredStories != null ? -50.h : 0,
              0,
            ),
            child: Lottie.asset(
              AppAnimations.robot,
              width: 170.w,
              height: 170.h,
            ),
          ),
        ),
        Center(child: _middleSection(context, homeViewModel)),
        const Spacer(),
        _bottomSection(context, homeViewModel, isLoading),
        SizedBox(height: 98.h),
      ],
    );
  }

  // MARK: - middleSection
  Widget _middleSection(BuildContext context, HomeViewModel homeViewModel) {
    if (homeViewModel.pageController == null) {
      homeViewModel.setPageController(PageController(
          viewportFraction: 393.w / MediaQuery.of(context).size.width));
    }
    return homeViewModel.filteredStories == null
        ? _storyNotSelected(context, homeViewModel)
        : _storySelected(context, homeViewModel);
  }

  // MARK: - storyNotSelected (middleSection)
  Widget _storyNotSelected(BuildContext context, HomeViewModel homeViewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Text(
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            "Hi! I'm EngBot (잉봇).\nYou can set the expected time, category, and difficulty below to get a story :)",
            textAlign: TextAlign.center,
            style: FontManager.current.font_16.copyWith(
              color: ThemeManager.current.text_1,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            "안녕! 나는 EngBot(잉봇)이야.\n밑의 예상시간, 카테고리, 난이도를 설정해서 스토리를 불러올 수 있어 :)",
            textAlign: TextAlign.center,
            style: FontManager.current.font_16.copyWith(
              color: ThemeManager.current.text_2,
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - storySelected (middleSection)
  Widget _storySelected(BuildContext context, HomeViewModel homeViewModel) {
    final stories = homeViewModel.filteredStories;
    if (stories == null || stories.isEmpty) {
      return const Center(
          child:
              Text(maxLines: 5, overflow: TextOverflow.ellipsis, "스토리가 없습니다"));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 220.h,
          child: PageView.builder(
            controller: homeViewModel.pageController,
            itemCount: stories.length,
            onPageChanged: (index) {
              homeViewModel.setFilteredStoryIndex(index + 1);
            },
            itemBuilder: (context, index) {
              return _storyCard(
                context,
                stories[index],
                "${homeViewModel.filteredStoryIndex}/${stories.length}",
              );
            },
          ),
        ),
      ],
    );
  }

  // MARK: - storyCard
  Widget _storyCard(BuildContext context, CachedStory story, String indexText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeManager.current.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: ThemeManager.current.text_1,
            width: 0.2.w,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 15.h),
            Row(
              children: [
                SizedBox(width: 21.w),
                Text(
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  "제목",
                  textAlign: TextAlign.center,
                  style: FontManager.current.font_14.copyWith(
                    color: ThemeManager.current.text_2,
                  ),
                ),
                const Spacer(),
                Text(
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  indexText,
                  textAlign: TextAlign.end,
                  style: FontManager.current.font_14.copyWith(
                    color: ThemeManager.current.text_2,
                  ),
                ),
                SizedBox(width: 21.w),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SizedBox(width: 30.w),
                if (story.lastReadScriptIndex == 0) ...[
                  Container(
                    padding: EdgeInsets.only(
                      left: 7.w,
                      right: 7.w,
                      bottom: 2.h,
                      top: 2.h,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ThemeManager.current.text_2,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Text(
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      'New',
                      style: FontManager.current.font_14.copyWith(
                        color: ThemeManager.current.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
                if (story.lastReadScriptIndex != 0) ...[
                  Container(
                    padding: EdgeInsets.only(
                      left: 7.w,
                      right: 7.w,
                      bottom: 2.h,
                      top: 2.h,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ThemeManager.current.white,
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: ThemeManager.current.text_1,
                        width: 0.8.w,
                      ),
                    ),
                    child: Text(
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      'Read',
                      style: FontManager.current.font_14.copyWith(
                        color: ThemeManager.current.text_1,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
                Text(
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  story.title,
                  textAlign: TextAlign.right,
                  style: FontManager.current.font_16.copyWith(
                    color: ThemeManager.current.text_1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 17.h),
            Row(
              children: [
                SizedBox(width: 21.w),
                Text(
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  "카테고리",
                  textAlign: TextAlign.center,
                  style: FontManager.current.font_14.copyWith(
                    color: ThemeManager.current.text_2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SizedBox(width: 30.w),
                Text(
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  story.category,
                  textAlign: TextAlign.center,
                  style: FontManager.current.font_16.copyWith(
                    color: ThemeManager.current.text_1,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // MARK: - Read Button
            GestureDetector(
              onTap: () async {
                HapticFeedback.heavyImpact();
                context.read<HomeViewModel>().setSelectedStory(story);

                final getScripts =
                    await context.read<StoryViewModel>().getScripts(story.id);
                context.read<StoryViewModel>().init(story.lastReadScriptIndex);
                if (getScripts) {
                  context.goNamed("storyView");
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 21.w),
                child: Container(
                  height: 39.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.button,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "읽기",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // MARK: - bottomSection
  Widget _bottomSection(
    BuildContext context,
    HomeViewModel homeViewModel,
    bool isLoading,
  ) {
    String loadingText = homeViewModel.initializeProgress == "cache"
        ? "재밌는 이야기를 불러오는 중입니다...."
        : "새롭게 추가된 이야기를 불러오는 중입니다.....";
    return Column(
      children: [
        // 🔹 로딩 중이면 인디케이터와 텍스트 표시
        if (isLoading)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: ThemeManager.current.button,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  loadingText,
                  style: FontManager.current.font_16.copyWith(
                    color: ThemeManager.current.text_1,
                  ),
                ),
              ],
            ),
          ),

        // 🔹 로딩이 끝나면 기존 버튼 UI 표시
        if (!isLoading)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: ThemeManager.current.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ThemeManager.current.black,
                    width: 0.2.w,
                  ),
                ),
                child: DropdownButton<String?>(
                  value: homeViewModel.storyTime?.displayText,
                  hint: const Text(
                      maxLines: 5, overflow: TextOverflow.ellipsis, "예상시간"),
                  style: FontManager.current.font_16
                      .copyWith(color: ThemeManager.current.text_1),
                  alignment: Alignment.center,
                  underline: const SizedBox.shrink(),
                  onChanged: (String? newValue) {
                    HapticFeedback.heavyImpact();
                    homeViewModel.setStoryTime(newValue == null
                        ? null
                        : StoryTime.values.firstWhere(
                            (element) => element.displayText == newValue));
                  },
                  items: [
                    DropdownMenuItem<String?>(
                      value: null,
                      child: Text(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        "예상시간",
                        style: FontManager.current.font_16.copyWith(
                          color: ThemeManager.current.grey_2,
                        ),
                      ),
                    ),
                    ...homeViewModel
                        .getAvailableStoryTimes()
                        .map<DropdownMenuItem<String?>>((StoryTime value) {
                      return DropdownMenuItem<String?>(
                        value: value.displayText,
                        child: Text(
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            value.displayText),
                      );
                    }),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: ThemeManager.current.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ThemeManager.current.black,
                    width: 0.2.w,
                  ),
                ),
                child: DropdownButton<StoryCategory?>(
                  value: homeViewModel.storyCategory,
                  alignment: Alignment.center,
                  style: FontManager.current.font_16
                      .copyWith(color: ThemeManager.current.text_1),
                  menuMaxHeight: 250.h,
                  underline: const SizedBox.shrink(),
                  onChanged: (StoryCategory? newValue) {
                    HapticFeedback.heavyImpact();
                    homeViewModel.setStoryCategory(newValue);
                  },
                  items: [
                    DropdownMenuItem<StoryCategory?>(
                      value: null,
                      child: Text(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        "카테고리",
                        style: FontManager.current.font_16.copyWith(
                          color: ThemeManager.current.grey_2,
                        ),
                      ),
                    ),
                    ...homeViewModel
                        .getAvailableStoryCategories()
                        .map<DropdownMenuItem<StoryCategory?>>(
                      (StoryCategory value) {
                        return DropdownMenuItem<StoryCategory?>(
                          value: value,
                          child: Text(
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              displayCategoryText(value)),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: ThemeManager.current.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ThemeManager.current.black,
                    width: 0.2.w,
                  ),
                ),
                child: DropdownButton<int?>(
                  value: homeViewModel.storyLevel,
                  alignment: Alignment.center,
                  style: FontManager.current.font_16
                      .copyWith(color: ThemeManager.current.text_1),
                  menuMaxHeight: 250.h,
                  underline: const SizedBox.shrink(),
                  onChanged: (int? newValue) {
                    HapticFeedback.heavyImpact();
                    homeViewModel.setStoryLevel(newValue);
                  },
                  items: [
                    DropdownMenuItem<int?>(
                      value: null,
                      child: Text(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        "난이도",
                        style: FontManager.current.font_16.copyWith(
                          color: ThemeManager.current.grey_2,
                        ),
                      ),
                    ),
                    ...homeViewModel
                        .getAvailableStoryLevels()
                        .map<DropdownMenuItem<int?>>((int value) {
                      return DropdownMenuItem<int?>(
                        value: value,
                        child: Text(
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            value.toString()),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(width: 5.w),
            ],
          ),
      ],
    );
  }

  // MARK: - theme setting bottom modal
  void _showThemeSettingBottomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ThemeManager.current.white,
      builder: (context) {
        return Container(
          height: 350.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ThemeManager.current.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 300.h,
                  width: double.infinity,
                  child: _colorThemePageView(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // MARK: - color theme page view
  Widget _colorThemePageView(BuildContext context) {
    return SizedBox(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: PageController(
            viewportFraction: 393.w / MediaQuery.of(context).size.width),
        itemCount: ThemeManager().getThemeCount(),
        onPageChanged: (index) {
          context.read<HomeViewModel>().setSelectedThemeColorIndex(index);
        },
        itemBuilder: (context, index) {
          final colors = ThemeManager()
              .getAllThemeColors()
              .map((e) => ThemeManager().getThemeColorFromEnum(e))
              .toList();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                '테마 색상 선택',
                style: FontManager.current.font_20.copyWith(
                  color: colors[index].text_1,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (i) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: [
                            colors[index].grey_1,
                            colors[index].grey_2,
                            colors[index].grey_3,
                            colors[index].grey_4,
                          ][i],
                          border: Border.all(
                            color: colors[index].black.withAlpha(30),
                            width: 0.1.w,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  ThemeManager().getThemeCount(),
                  (i) {
                    if (i == index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Container(
                          height: 16.h,
                          width: 16.w,
                          decoration: BoxDecoration(
                            color: colors[index].button,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Container(
                          height: 12.h,
                          width: 12.w,
                          decoration: BoxDecoration(
                            color: colors[index].background,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  HapticFeedback.heavyImpact();
                  final selectedThemeIndex =
                      context.read<HomeViewModel>().selectedThemeColorIndex;
                  final selectedTheme =
                      ThemeManager().getAllThemeColors()[selectedThemeIndex];
                  await ThemeManager().setTheme(selectedTheme);
                  context
                      .read<HomeViewModel>()
                      .setSelectedThemeColorIndex(0); // 초기화
                  context.pop();
                },
                child: Container(
                  height: 45.h,
                  width: 300.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors[index].button,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "적용",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // MARK: - font setting bottom modal
  void _showFontSettingBottomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ThemeManager.current.white,
      builder: (context) {
        return Container(
          height: 350.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ThemeManager.current.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
          ),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 300.h,
                  width: double.infinity,
                  child: _fontPageView(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // MARK: - font page view
  Widget _fontPageView(BuildContext context) {
    return SizedBox(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: PageController(
            viewportFraction: 393.w / MediaQuery.of(context).size.width),
        itemCount: FontManager().getFontCount(),
        onPageChanged: (index) {
          context.read<HomeViewModel>().setSelectedThemeFontIndex(index);
        },
        itemBuilder: (context, index) {
          final fonts =
              FontManager().getFontNames().map((e) => e.name).toList();
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                '폰트 선택',
                style: AppTextStyles(fonts[index]).font_20.copyWith(
                      color: ThemeManager.current.text_1,
                    ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "This is  [ ${FontManager().getFontName(fonts[index])} ]  입니다.",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyles(fonts[index]).font_18.copyWith(
                          color: ThemeManager.current.text_1,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  FontManager().getFontCount(),
                  (i) {
                    if (i == index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Container(
                          height: 16.h,
                          width: 16.w,
                          decoration: BoxDecoration(
                            color: ThemeManager.current.button,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Container(
                          height: 12.h,
                          width: 12.w,
                          decoration: BoxDecoration(
                            color: ThemeManager.current.background,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  HapticFeedback.heavyImpact();
                  final selectedFontIndex =
                      context.read<HomeViewModel>().selectedThemeFontIndex;
                  final selectedFont =
                      FontManager().getFontNames()[selectedFontIndex].name;
                  await FontManager().setFont(selectedFont);
                  context
                      .read<HomeViewModel>()
                      .setSelectedThemeFontIndex(0); // 초기화
                  context.pop();
                },
                child: Container(
                  height: 45.h,
                  width: 300.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.button,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "적용",
                    style: AppTextStyles(fonts[index]).font_16.copyWith(
                          color: ThemeManager.current.white,
                        ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
