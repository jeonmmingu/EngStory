import 'dart:math';

import 'package:eng_story/core/enums/story_time.dart';
import 'package:eng_story/core/tests/manage_story.dart';
import 'package:eng_story/core/tests/story/%EB%A1%9C%EC%A0%9C%ED%83%80%20%EC%8A%A4%ED%86%A4%EC%9D%B4%20%ED%95%B4%EB%8F%85%EB%90%9C%20%EA%B3%BC%EC%A0%95.dart';
import 'package:eng_story/core/tests/story/%EC%84%B8%EA%B3%84%20%EC%B5%9C%EC%B4%88%EC%9D%98%20%EC%8B%A0%EB%AC%B8%EC%9D%80%20%EC%96%B4%EB%96%A4%20%EB%AA%A8%EC%8A%B5%EC%9D%B4%EC%97%88%EC%9D%84%EA%B9%8C.dart';
import 'package:eng_story/core/tests/story/%EC%9D%B4%EC%8A%A4%ED%84%B0%EC%84%AC%20%EB%AA%A8%EC%95%84%EC%9D%B4%20%EC%84%9D%EC%83%81%EC%9D%98%20%EC%88%A8%EA%B2%A8%EC%A7%84%20%EB%B9%84%EB%B0%80.dart';
import 'package:eng_story/core/tests/story/%EC%A4%91%EC%84%B8%20%EC%9C%A0%EB%9F%BD%EC%97%90%EC%84%9C%20%EB%A7%88%EB%85%80%20%EC%82%AC%EB%83%A5%EC%9D%B4%20%EB%B2%8C%EC%96%B4%EC%A7%84%20%EC%9D%B4%EC%9C%A0.dart';
import 'package:eng_story/core/utils/animations.dart';
import 'package:eng_story/core/utils/colors.dart';
import 'package:eng_story/core/utils/fonts.dart';
import 'package:eng_story/core/utils/images.dart';
import 'package:eng_story/view_models/home_view_model.dart';
import 'package:eng_story/view_models/story_view_model.dart';
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
      future: context.read<HomeViewModel>().initializeApp(),
      builder: (context, snapshot) => Scaffold(
        backgroundColor: AppColors.background,
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 178.h,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간
            curve: Curves.easeOut, // 부드러운 움직임
            transform: Matrix4.translationValues(
                0, homeViewModel.selectedStory != null ? -50.h : 0, 0),
            child: Lottie.asset(
              AppAnimations.robot,
              width: 170.w,
              height: 170.h,
            ),
          ),
          _middleSection(context, homeViewModel),
          const Spacer(),
          _bottomSection(context, homeViewModel, isLoading),
          SizedBox(height: 98.h),
        ],
      ),
    );
  }

  // MARK: - middleSection
  Widget _middleSection(BuildContext context, HomeViewModel homeViewModel) {
    return homeViewModel.selectedStory == null
        ? _storyNotSelected(context, homeViewModel)
        : _storySelected(context, homeViewModel);
  }

  // MARK: - storyNotSelected (middleSection)
  Widget _storyNotSelected(BuildContext context, HomeViewModel homeViewModel) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        Text(
          "Hello! I'm EngBot.\nPress the dice button to choose a story.",
          textAlign: TextAlign.center,
          style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
            color: AppColors.text_1,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          "안녕! 나는 EngBot이야.\n주사위 버튼을 눌러서 스토리를 선택해줘.",
          textAlign: TextAlign.center,
          style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
            color: AppColors.text_2,
          ),
        )
      ],
    );
  }

  // MARK: - storySelected (middleSection)
  Widget _storySelected(BuildContext context, HomeViewModel homeViewModel) {
    return Container(
      width: 341.w,
      height: 173.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: Colors.black,
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 27.h),
          Row(
            children: [
              SizedBox(width: 21.w),
              Text(
                "제목",
                textAlign: TextAlign.center,
                style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                  color: AppColors.text_1,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 200.w,
                child: Text(
                  homeViewModel.selectedStory!.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                    color: AppColors.text_1,
                  ),
                ),
              ),
              SizedBox(width: 21.w),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              SizedBox(width: 21.w),
              Text(
                "카테고리",
                textAlign: TextAlign.center,
                style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                  color: AppColors.text_1,
                ),
              ),
              const Spacer(),
              Text(
                homeViewModel.selectedStory!.category,
                textAlign: TextAlign.center,
                style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                  color: AppColors.text_2,
                ),
              ),
              SizedBox(width: 21.w),
            ],
          ),
          SizedBox(height: 21.h),
          GestureDetector(
            onTap: () async {
              HapticFeedback.heavyImpact();
              final getScripts = await context
                  .read<StoryViewModel>()
                  .getScripts(homeViewModel.selectedStory!.id);
              if (getScripts) {
                context.goNamed("storyView");
              }
            },
            child: Container(
              width: 277.w,
              height: 39.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.button,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                "읽기",
                style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
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
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.button,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  loadingText,
                  style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                    color: AppColors.text_1,
                  ),
                ),
              ],
            ),
          ),

        // 🔹 로딩이 끝나면 기존 버튼 UI 표시
        if (!isLoading)
          Row(
            children: [
              SizedBox(width: 45.w),
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  homeViewModel.setStoryTime(StoryTime.short);
                },
                child: Container(
                  width: 80.w,
                  height: 61.h,
                  alignment: Alignment.center,
                  child: Text(
                    StoryTime.short.displayText,
                    style: homeViewModel.storyTime == StoryTime.short
                        ? AppTextStyles.SejongGeulggot_20_regular.copyWith(
                            color: AppColors.button)
                        : AppTextStyles.SejongGeulggot_16_regular.copyWith(
                            color: AppColors.text_1,
                          ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  HapticFeedback.heavyImpact();
                  List<String> storyIds = [
                    dummyStoryRosetta.id,
                    dummyStoryFirstNewspaper.id,
                    dummyStoryEasterMoai.id,
                    dummyStoryWitchHunt.id,
                  ];
                  int randomIndex = Random().nextInt(4);
                  final story =
                      await ManageStory().getStory(storyIds[randomIndex]);
                  homeViewModel.setSelectedStory(story!);
                },
                child: Container(
                  width: 61.w,
                  height: 61.h,
                  alignment: Alignment.center,
                  child: Image.asset(AppImages.diceButton),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  homeViewModel.setStoryTime(StoryTime.medium);
                },
                child: Container(
                  width: 80.w,
                  height: 61.h,
                  alignment: Alignment.center,
                  child: Text(
                    StoryTime.medium.displayText,
                    style: homeViewModel.storyTime == StoryTime.medium
                        ? AppTextStyles.SejongGeulggot_20_regular.copyWith(
                            color: AppColors.button)
                        : AppTextStyles.SejongGeulggot_16_regular.copyWith(
                            color: AppColors.text_1,
                          ),
                  ),
                ),
              ),
              SizedBox(width: 45.w),
            ],
          ),
      ],
    );
  }
}
