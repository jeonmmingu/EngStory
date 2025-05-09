import 'dart:io';
import 'dart:ui';

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

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          storyViewModel.cancelAutoPlay();
          homeViewModel.notify();
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: ThemeManager.current.background,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              homeViewModel.notify();
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
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _chatSection(
                context,
                storyViewModel,
              ),
            ],
          ),
          Positioned(
            top: 0.h,
            left: 0.w,
            right: 0.w,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  height: Platform.isAndroid ? 200.h : 170.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.background.withOpacity(0.85),
                  ),
                  child: Column(
                    children: [
                      _header(context, homeViewModel),
                      Center(
                        child: Lottie.asset(
                          "assets/animations/robot.json",
                          width: 120.w,
                          height: 120.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - storyTellerChatSections
  Widget _chatSection(
    BuildContext context,
    StoryViewModel storyViewModel,
  ) {
    var scripts = List.from(storyViewModel.storyTellerScripts);
    scripts.addAll(storyViewModel.meScripts);
    scripts.sort((a, b) => a.index.compareTo(b.index));

    if (scripts.isEmpty) {
      return Container(
        color: ThemeManager.current.background,
      );
    }

    // return Column(
    //   children: scripts.map(
    //     (script) {
    //       if (script.role != "me") {
    //         return _storyTellerChat(context, script, storyViewModel);
    //       } else {
    //         return _myChat(context, script, storyViewModel);
    //       }
    //     },
    //   ).toList(),
    // );

    return Expanded(
      child: AnimatedList(
        key: storyViewModel.listKey,
        initialItemCount: scripts.length,
        controller: storyViewModel.scrollController,
        physics: const BouncingScrollPhysics(),
        reverse: false,
        padding: EdgeInsets.only(
          top: Platform.isAndroid ? 210.h : 180.h,
          bottom: 20.h,
        ),
        itemBuilder: (
          BuildContext context,
          int index,
          Animation<double> animation,
        ) {
          final script = scripts[index];
          final chatWidget = script.role != "me"
              ? _storyTellerChat(context, script, storyViewModel)
              : _myChat(context, script, storyViewModel);

          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.5, end: 1.0)
                  .chain(CurveTween(curve: Curves.easeOutBack))
                  .animate(animation),
              child: chatWidget,
            ),
          );
        },
      ),
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
        if (storyViewModel.isAutoPlaying) return;

        HapticFeedback.mediumImpact();
        await TtsManager().stop();
        TtsManager().speak(storyScript.text_en);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 15.h, right: 30.w),
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
                  if (!storyViewModel.isAutoPlaying)
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
              if (storyViewModel.isAutoPlaying) return;

              HapticFeedback.mediumImpact();
              await TtsManager().stop();
              TtsManager().speak(meScript.text_en);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 15.h, bottom: 30.h, left: 30.w),
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
                        if (!storyViewModel.isAutoPlaying)
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
                (storyViewModel.selectedScripts.length - 1) *
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
          // MARK: - auto play Button
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () async {
                HapticFeedback.mediumImpact();
                storyViewModel.toggleAutoPlay();

                if (storyViewModel.isAutoPlaying) {
                  await storyViewModel
                      .startAutoPlay(homeViewModel.selectedStory!.id);
                } else {
                  await storyViewModel.cancelAutoPlay();
                }
              },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation.drive(
                    CurveTween(curve: Curves.bounceInOut),
                  ),
                  child: child,
                ),
                child: Container(
                  key: ValueKey(storyViewModel.isAutoPlaying),
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: Icon(
                    storyViewModel.isAutoPlaying
                        ? Icons.pause
                        : Icons.graphic_eq_outlined,
                    color: ThemeManager.current.button,
                    size: 40.w,
                  ),
                ),
              ),
            ),
          ),
          // MARK: - Play Button
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () async {
                if (storyViewModel.isAutoPlaying) {
                  return;
                }
                HapticFeedback.mediumImpact();
                storyViewModel.playStory();
                homeViewModel.updateLastReadScriptIndex(
                  homeViewModel.selectedStory!.id,
                  storyViewModel.currentIdx,
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (storyViewModel.isAutoPlaying) SizedBox(height: 20.h),
                  Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: (storyViewModel.isAutoPlaying)
                            ? ThemeManager.current.grey_1
                            : ThemeManager.current.button,
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
                  if (storyViewModel.isAutoPlaying) ...[
                    SizedBox(height: 5.h),
                    Text(
                      "자동 재생 중",
                      style: FontManager.current.font_14.copyWith(
                        color: ThemeManager.current.grey_3,
                      ),
                    ),
                  ],
                ],
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
              onPressed: () async {
                storyViewModel.resetStoryScripts();
                homeViewModel.updateLastReadScriptIndex(
                  homeViewModel.selectedStory!.id,
                  0,
                );
                await storyViewModel.cancelAutoPlay();
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
