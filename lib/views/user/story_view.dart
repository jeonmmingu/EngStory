import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/font/font_manager.dart';
import 'package:eng_story/core/utils/images.dart';
import 'package:eng_story/core/utils/tts_manager.dart';
import 'package:eng_story/models/story_script.dart';
import 'package:eng_story/view_models/user/home_view_model.dart';
import 'package:eng_story/view_models/user/story_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class StoryView extends StatelessWidget {
  const StoryView({super.key});

  // MARK: - Build
  @override
  Widget build(BuildContext context) {
    final storyViewModel = Provider.of<StoryViewModel>(context);
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: ThemeManager.current.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context, homeViewModel),
            _body(context, homeViewModel, storyViewModel),
            Container(
              width: double.infinity,
              color: Colors.transparent,
              height: 150.h,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _progressBar(context, homeViewModel, storyViewModel),
                  _bottomSection(context, storyViewModel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: - header
  Widget _header(
    BuildContext context,
    HomeViewModel homeViewModel,
  ) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 50.h,
          alignment: Alignment.center,
          child: SizedBox(
            width: 300.w,
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              homeViewModel.selectedStory!.title,
              textAlign: TextAlign.center,
              style: FontManager.current.font_20.copyWith(
                color: ThemeManager.current.text_1,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0.w,
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
              width: 50.w,
              height: 50.h,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Image.asset(
                AppImages.backButton,
                width: 16.w,
                height: 16.h,
                color: ThemeManager.current.text_1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // MARK: - body
  Widget _body(
    BuildContext context,
    HomeViewModel homeViewModel,
    StoryViewModel storyViewModel,
  ) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Center(
              child: Lottie.asset(
                "assets/animations/robot.json",
                width: 130.w,
                height: 130.h,
              ),
            ),
            SizedBox(height: 25.h),
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    _storyTellerChatSections(
                      context,
                      storyViewModel.storyTellerScripts,
                      storyViewModel,
                    ),
                    SizedBox(height: 30.h),
                    _myChat(
                      context,
                      storyViewModel.meScripts.isEmpty
                          ? null
                          : storyViewModel.meScripts.first,
                      storyViewModel,
                    ),
                    SizedBox(height: 45.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: - storyTellerChatSections
  Widget _storyTellerChatSections(
    BuildContext context,
    List<StoryScript> storyScripts,
    StoryViewModel storyViewModel,
  ) {
    return Column(
      children: storyScripts.map((script) {
        return _storyTellerChat(
          context,
          script,
          storyViewModel,
        );
      }).toList(),
    );
  }

  // MARK: - storyTellerChat
  Widget _storyTellerChat(
    BuildContext context,
    StoryScript storyScript,
    StoryViewModel storyViewModel,
  ) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.mediumImpact();
        TtsManager().speak(storyScript.text_en);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: ThemeManager.current.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: ThemeManager.current.black,
              width: 0.4.w,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                storyScript.text_en,
                style: FontManager.current.font_18.copyWith(
                  color: ThemeManager.current.text_1,
                ),
              ),
              if (storyViewModel.languageMode != "Eng") ...[
                Divider(color: ThemeManager.current.text_2, thickness: 0.4.h),
                Text(
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  storyScript.text_ko,
                  style: FontManager.current.font_16.copyWith(
                    color: ThemeManager.current.text_2,
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // MARK: - myChat
  Widget _myChat(
    BuildContext context,
    StoryScript? meScript,
    StoryViewModel storyViewModel,
  ) {
    return meScript != null
        ? GestureDetector(
            onTap: () async {
              HapticFeedback.mediumImpact();
              TtsManager().speak(meScript.text_en);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ThemeManager.current.text_2,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: ThemeManager.current.black,
                  width: 0.4.w,
                ),
              ),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    meScript.text_en,
                    style: FontManager.current.font_18.copyWith(
                      color: ThemeManager.current.white,
                    ),
                  ),
                  if (storyViewModel.languageMode != "Eng") ...[
                    Divider(
                        color: ThemeManager.current.white, thickness: 0.4.h),
                    Text(
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      meScript.text_ko,
                      style: FontManager.current.font_16.copyWith(
                        color: ThemeManager.current.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  // MARK: - progressBar
  Widget _progressBar(
    BuildContext context,
    HomeViewModel homeViewModel,
    StoryViewModel storyViewModel,
  ) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 6.h,
          color: ThemeManager.current.grey_1,
        ),
        Positioned(
          child: Container(
            width: 393.w /
                storyViewModel.selectedScripts.length *
                storyViewModel.currentIdx,
            height: 6.h,
            color: ThemeManager.current.text_2,
          ),
        ),
      ],
    );
  }

  // MARK: - bottomSection
  Widget _bottomSection(BuildContext context, StoryViewModel storyViewModel) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    return Expanded(
      child: Row(
        children: [
          // MARK: - Rewind Button
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                storyViewModel.rewindStory();
                homeViewModel.updateLastReadScriptIndex(
                  homeViewModel.selectedStory!.id,
                  storyViewModel.currentIdx,
                );
              },
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.chatBackButton,
                  width: 35.w,
                  height: 35.h,
                  color: ThemeManager.current.button,
                ),
              ),
            ),
          ),
          // MARK: - Play Button
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                storyViewModel.playStory();
                homeViewModel.updateLastReadScriptIndex(
                  homeViewModel.selectedStory!.id,
                  storyViewModel.currentIdx,
                );
              },
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.button,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 4.w),
                      Image.asset(
                        AppImages.playButton,
                        width: 30.w,
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // MARK: - Translate Button
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                storyViewModel.changeLanguageMode();
              },
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.translateButton,
                  width: 35.w,
                  height: 35.h,
                  color: ThemeManager.current.button,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
