// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:eng_story/core/enums/story_category.dart';
import 'package:eng_story/core/enums/story_time.dart';
import 'package:eng_story/core/utils/animations.dart';
import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/font/font_manager.dart';
import 'package:eng_story/core/utils/font/fonts.dart';
import 'package:eng_story/core/utils/reading_quotes.dart';
import 'package:eng_story/core/utils/tts_manager.dart';
import 'package:eng_story/core/utils/tutorial_coach_mark_manager.dart';
import 'package:eng_story/models/cache/cached_story.dart';
import 'package:eng_story/view_models/user/home_view_model.dart';
import 'package:eng_story/view_models/user/story_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
        bottomNavigationBar:
            Provider.of<HomeViewModel>(context, listen: false).bannerAd == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    height: 55.h,
                    child: AdWidget(
                        ad: Provider.of<HomeViewModel>(context, listen: false)
                            .bannerAd!),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: Platform.isAndroid ? 50.h : 60.h,
            right: 30.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20.w),
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  TutorialCoachMarkManager().showTutorial(context);
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
                    Icons.help_outline_rounded,
                    color: ThemeManager.current.grey_4,
                    size: 28.sp,
                  ),
                ),
              ),
              const Spacer(),
              // Speech Speed Change Button
              GestureDetector(
                key: TutorialCoachMarkManager().speedButtonKey,
                onTap: () async {
                  HapticFeedback.heavyImpact();
                  // homeviemodel 에서 sppechSpeed 가져와서 저장
                  await homeViewModel.setSelectedSpeechSpeed();
                  _showSpeechSpeedSettingBottomModal(context);
                },
                child: Container(
                  width: 40.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.background,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Icon(
                    Icons.speed,
                    color: ThemeManager.current.grey_4,
                    size: 28.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              // Theme button
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  _showThemeSettingBottomModal(context);
                },
                child: Container(
                  key: TutorialCoachMarkManager().themeButtonKey,
                  width: 40.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.background,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Icon(
                    Icons.color_lens_outlined,
                    color: ThemeManager.current.grey_4,
                    size: 28.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              // Font Change Button
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  _showFontSettingBottomModal(context);
                },
                child: Container(
                  key: TutorialCoachMarkManager().fontButtonKey,
                  width: 40.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.background,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Icon(
                    Icons.font_download_outlined,
                    color: ThemeManager.current.grey_4,
                    size: 28.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 50.h),
        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간
            curve: Curves.easeOut, // 부드러운 움직임
            transform: Matrix4.translationValues(
              0,
              homeViewModel.filteredStories != null ? -25.h : 0,
              0,
            ),
            child: Lottie.asset(
              AppAnimations.robot,
              width: 170.w,
              height: 170.h,
            ),
          ),
        ),
        _middleSection(context, homeViewModel),
        if (homeViewModel.filteredStories != null) ...[
          SizedBox(height: 15.h),
          Center(
            child: Text(
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              "New 스토리를 처음 읽는 경우, 광고가 나와요.\n 읽기 시작한 스토리는 광고가 출력되지 않아요 :)",
              textAlign: TextAlign.center,
              style: FontManager.current.font_14.copyWith(
                color: ThemeManager.current.text_1,
              ),
            ),
          ),
        ],
        const Spacer(),
        _bottomSection(context, homeViewModel, isLoading),
        SizedBox(height: 40.h),
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
        : Center(child: _storySelected(context, homeViewModel));
  }

  // MARK: - storyNotSelected (middleSection)
  Widget _storyNotSelected(BuildContext context, HomeViewModel homeViewModel) {
    final quote = readingQuotes[Random().nextInt(readingQuotes.length)];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Container(
        width: 363.h,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text(
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              quote["text_en"] ?? "",
              textAlign: TextAlign.left,
              style: FontManager.current.font_16.copyWith(
                color: ThemeManager.current.text_1,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              quote["text_ko"] ?? "",
              textAlign: TextAlign.left,
              style: FontManager.current.font_16.copyWith(
                color: ThemeManager.current.text_2,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 363.w,
              child: Text(
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                "- ${quote["author"] ?? ""}",
                textAlign: TextAlign.right,
                style: FontManager.current.font_16.copyWith(
                  color: ThemeManager.current.text_2,
                ),
              ),
            ),
          ],
        ),
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
                  style: FontManager.current.font_16.copyWith(
                    color: ThemeManager.current.text_1,
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
                  if (story.lastReadScriptIndex == 0) {
                    await _showInterstitialAd(context);
                  }
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
              Column(
                key: TutorialCoachMarkManager().levelButtonKey,
                children: [
                  Text(
                    "난이도",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.text_2,
                    ),
                  ),
                  SizedBox(height: 5.h),
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
                            "선택",
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
                              value.toString(),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                key: TutorialCoachMarkManager().categoryButtonKey,
                children: [
                  Text(
                    "카테고리",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.text_2,
                    ),
                  ),
                  SizedBox(height: 5.h),
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
                            "선택",
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
                ],
              ),
              Column(
                key: TutorialCoachMarkManager().requiredTimeButtonKey,
                children: [
                  Text(
                    "예상시간",
                    style: FontManager.current.font_16.copyWith(
                      color: ThemeManager.current.text_2,
                    ),
                  ),
                  SizedBox(height: 5.h),
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
                            "선택",
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
                ],
              ),
              SizedBox(width: 5.w),
            ],
          ),
      ],
    );
  }

  // MARK: - speech speed setting bottom modal
  void _showSpeechSpeedSettingBottomModal(BuildContext context) {
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
                  child: _speechSpeedPageView(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // MARK: - speech speed page view
  Widget _speechSpeedPageView(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Column(
      children: [
        SizedBox(height: 30.h),
        Text(
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          '읽기 속도 선택',
          style: FontManager.current.font_20.copyWith(
            color: ThemeManager.current.text_1,
          ),
        ),
        SizedBox(height: 40.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              "Hello, this is a test sentence.\nPlease check the speed.",
              textAlign: TextAlign.center,
              style: FontManager.current.font_16.copyWith(
                color: ThemeManager.current.black,
              ),
            ),
            SizedBox(width: 20.w),
            GestureDetector(
              onTap: () async {
                HapticFeedback.heavyImpact();
                await TtsManager().setSpeechRate(
                  homeViewModel.selectedSpeechSpeed,
                  true,
                );
                TtsManager().testTts.speak(
                      "Hello, this is a test sentence.\n Please check the speed.",
                    );
              },
              child: Container(
                height: 40.h,
                width: 40.w,
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_circle,
                  color: ThemeManager.current.text_1,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),
        SizedBox(
          width: double.infinity,
          height: 40.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (homeViewModel.selectedSpeechSpeed < 0.1) {
                    return;
                  }
                  HapticFeedback.heavyImpact();
                  homeViewModel.changeSpeechSpeed(false);
                },
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: homeViewModel.selectedSpeechSpeed < 0.1
                        ? ThemeManager.current.grey_1
                        : ThemeManager.current.text_1,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              Container(
                height: 40.h,
                width: 40.w,
                alignment: Alignment.center,
                child: Text(
                  homeViewModel.selectedSpeechSpeed.toStringAsFixed(1),
                  style: FontManager.current.font_18.copyWith(
                    color: ThemeManager.current.text_1,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              GestureDetector(
                onTap: () {
                  if (homeViewModel.selectedSpeechSpeed == 1.0) {
                    return;
                  }
                  HapticFeedback.heavyImpact();
                  homeViewModel.changeSpeechSpeed(true);
                },
                child: Container(
                  height: 40.h,
                  width: 40.w,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: homeViewModel.selectedSpeechSpeed == 1.0
                        ? ThemeManager.current.grey_1
                        : ThemeManager.current.text_1,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {
            HapticFeedback.heavyImpact();
            await TtsManager().setSpeechRate(
              homeViewModel.selectedSpeechSpeed,
              false,
            );
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
              style: FontManager.current.font_16.copyWith(
                color: ThemeManager.current.white,
              ),
            ),
          ),
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

  Future<void> _showInterstitialAd(BuildContext context) async {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    await homeViewModel.createInterstitialAd();

    if (homeViewModel.interstitialAd != null) {
      homeViewModel.interstitialAd!.fullScreenContentCallback =
          FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) async {
          await ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (ad, error) async {
          await ad.dispose();
          homeViewModel.setInterstitialAdNull();
        },
      );
      await homeViewModel.interstitialAd!.show();
      homeViewModel.setInterstitialAdNull();
    }
  }
}
