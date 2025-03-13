import 'package:eng_story/core/enums/story_time.dart';
import 'package:eng_story/core/tests/manage_story.dart';
import 'package:eng_story/core/tests/story/story_little_prince.dart';
import 'package:eng_story/core/tests/story/the_three_little_pigs.dart';
import 'package:eng_story/core/utils/animations.dart';
import 'package:eng_story/core/utils/colors.dart';
import 'package:eng_story/core/utils/fonts.dart';
import 'package:eng_story/core/utils/images.dart';
import 'package:eng_story/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// Home 화면
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // MARK: build
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _body(context, homeViewModel),
    );
  }

  // MARK: - body
  Widget _body(BuildContext context, HomeViewModel homeViewModel) {
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
          _bottomSection(context, homeViewModel),
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
              Text(
                homeViewModel.selectedStory!.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                  color: AppColors.text_1,
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
          Container(
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
          )
        ],
      ),
    );
  }

  // MARK: - bottomSection
  Widget _bottomSection(BuildContext context, HomeViewModel homeViewModel) {
    return Row(
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
            final story =
                await ManageStory().getStory(dummyStoryThreeLittlePigs.id);
            homeViewModel.setSelectedStory(story!);
          },
          child: Container(
            width: 61.w,
            height: 61.h,
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.diceButton,
            ),
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
    );
  }
}
