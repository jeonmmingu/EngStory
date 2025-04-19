import 'dart:io';

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
          height: Platform.isAndroid ? 80.h : 50.h,
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
          left: 5.w,
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
              width: Platform.isAndroid ? 75.w : 50.w,
              height: Platform.isAndroid ? 75.h : 50.h,
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
        Positioned(
          right: 12.w,
          child: GestureDetector(
            onTap: () {
              HapticFeedback.heavyImpact();
              // show dialog (리셋 확인 다이어로그)
              _resetDialog(
                context,
                homeViewModel,
                Provider.of<StoryViewModel>(context, listen: false),
              );
            },
            child: Container(
              width: Platform.isAndroid ? 75.w : 50.w,
              height: Platform.isAndroid ? 75.h : 50.h,
              color: Colors.transparent,
              alignment: Alignment.center,
              // Icons에서 설정 이미지로 변경
              child: Icon(
                Icons.restart_alt_rounded,
                color: ThemeManager.current.text_1,
                size: 26.w,
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
                  Padding(
                    padding: EdgeInsets.only(
                      left: 0.w,
                      right: 20.w,
                    ),
                    child: _storyTellerChatSections(
                      context,
                      storyViewModel.storyTellerScripts,
                      storyViewModel,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 0.w,
                    ),
                    child: _myChat(
                      context,
                      storyViewModel.meScripts.isEmpty
                          ? null
                          : storyViewModel.meScripts.first,
                      storyViewModel,
                    ),
                  ),
                  SizedBox(height: 45.h),
                ],
              ),
            ),
          ),
        ],
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
        await TtsManager().stop();
        TtsManager().speak(storyScript.text_en);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Container(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 7.h,
            bottom: 7.h,
          ),
          width: double.infinity,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: ThemeManager.current.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.r),
              bottomRight: Radius.circular(20.r),
            ),
            border: Border.all(
              color: ThemeManager.current.text_1,
              width: 0.2.w,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      storyScript.text_en,
                      style: FontManager.current.font_18.copyWith(
                        color: ThemeManager.current.text_1,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -14.w,
                    bottom: 0.h,
                    child: SizedBox(
                      width: 21.w,
                      height: 21.h,
                      child: Center(
                        child: Icon(
                          Icons.volume_up,
                          color: ThemeManager.current.text_2,
                          size: 15.w,
                        ),
                      ),
                    ),
                  ),
                ],
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
              await TtsManager().stop();
              TtsManager().speak(meScript.text_en);
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 12.w,
                right: 20.w,
                top: 7.h,
                bottom: 7.h,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ThemeManager.current.text_2,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  bottomLeft: Radius.circular(12.r),
                ),
                border: Border.all(
                  color: ThemeManager.current.text_1,
                  width: 0.4.w,
                ),
              ),
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          meScript.text_en,
                          style: FontManager.current.font_18.copyWith(
                            color: ThemeManager.current.white,
                          ),
                        ),
                      ),
                      Positioned(
                        right: -14.w,
                        bottom: 1.h,
                        child: SizedBox(
                          width: 21.w,
                          height: 21.h,
                          child: Center(
                            child: Icon(
                              Icons.volume_up,
                              color: ThemeManager.current.white,
                              size: 15.w,
                            ),
                          ),
                        ),
                      ),
                    ],
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

  // MARK: - resetDialog
  void _resetDialog(
    BuildContext context,
    HomeViewModel homeViewModel,
    StoryViewModel storyViewModel,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "이야기 초기화",
            style: FontManager.current.font_20.copyWith(
              color: ThemeManager.current.text_1,
            ),
          ),
          content: Text(
            "이야기를 처음으로 되돌리시겠습니까?",
            style: FontManager.current.font_16.copyWith(
              color: ThemeManager.current.text_1,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                storyViewModel.resetStoryScripts();
                homeViewModel.updateLastReadScriptIndex(
                  homeViewModel.selectedStory!.id,
                  0,
                );
                context.pop();
              },
              child: Text(
                "확인",
                style: FontManager.current.font_16.copyWith(
                  color: ThemeManager.current.text_2,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(
                "취소",
                style: FontManager.current.font_16.copyWith(
                  color: ThemeManager.current.text_1,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
