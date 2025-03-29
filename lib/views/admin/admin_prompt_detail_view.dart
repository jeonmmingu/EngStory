import 'package:eng_story/core/enums/story_category.dart';
import 'package:eng_story/core/enums/story_time.dart';
import 'package:eng_story/core/enums/story_tone.dart';
import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/fonts.dart';
import 'package:eng_story/core/utils/images.dart';
import 'package:eng_story/view_models/admin/admin_prompt_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AdminPromptDetailView extends StatelessWidget {
  const AdminPromptDetailView({super.key});

  // MARK: - build
  @override
  Widget build(BuildContext context) {
    final adminPromptViewModel = Provider.of<AdminPromptViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          // 배경
          Container(
            width: double.infinity,
            height: double.infinity, // 배경 높이 조절
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(color: ThemeManager.current.background),
            child: Container(
              height: 220.h,
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: ThemeManager.current.grey_2,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10.h, // 배경과 살짝 겹치게 배치
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(context, adminPromptViewModel),
                  SizedBox(height: 20.h),
                  _promptInfoSection(context, adminPromptViewModel),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - header
  Widget _header(
    BuildContext context,
    AdminPromptViewModel adminPromptViewModel,
  ) {
    return SizedBox(
      height: 150.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20.w),
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  width: 18.w,
                  height: 18.h,
                  alignment: Alignment.center,
                  child: Image.asset(AppImages.backButton),
                ),
              ),
              SizedBox(width: 18.w),
              Text(
                adminPromptViewModel.selectedPrompt!.title,
                style: AppTextStyles.SejongGeulggot_22_regular,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 40.w),
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  debugPrint("add story");
                  context.goNamed('addStory');
                },
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.background,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                        color: ThemeManager.current.black, width: 0.1),
                  ),
                  child: Icon(
                    Icons.note_add,
                    size: 30.h,
                    color: ThemeManager.current.button,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  debugPrint("edit");
                },
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.background,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                        color: ThemeManager.current.black, width: 0.1),
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 30.h,
                    color: ThemeManager.current.button,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  HapticFeedback.heavyImpact();
                  debugPrint("delete");
                  try {
                    await adminPromptViewModel.deletePrompt(adminPromptViewModel
                        .selectedPrompt!.createdAt
                        .toString());
                    context.pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("프롬프트 삭제에 실패했습니다. ($e)"),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.background,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                        color: ThemeManager.current.black, width: 0.1),
                  ),
                  child: Icon(
                    Icons.delete,
                    size: 30.h,
                    color: ThemeManager.current.button,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  debugPrint("copy");
                  Clipboard.setData(
                    ClipboardData(
                        text: adminPromptViewModel.selectedPrompt!.promptText),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("클립보드에 복사되었습니다!"),
                    ),
                  );
                },
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: ThemeManager.current.background,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(
                        color: ThemeManager.current.black, width: 0.1),
                  ),
                  child: Icon(
                    Icons.copy,
                    size: 26.h,
                    color: ThemeManager.current.button,
                  ),
                ),
              ),
              SizedBox(width: 40.w),
            ],
          ),
        ],
      ),
    );
  }

  // MARK: - promptInfoSection
  Widget _promptInfoSection(
    BuildContext context,
    AdminPromptViewModel adminPromptViewModel,
  ) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 30.w),
                Text("제목", style: AppTextStyles.SejongGeulggot_16_regular),
                const Spacer(),
                SizedBox(
                  width: 280.w,
                  child: Text(
                    adminPromptViewModel.selectedPrompt!.title,
                    style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                      color: ThemeManager.current.text_2,
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
              ],
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 30.w),
                Text("주제", style: AppTextStyles.SejongGeulggot_16_regular),
                const Spacer(),
                SizedBox(
                  width: 280.w,
                  child: Text(
                    adminPromptViewModel.selectedPrompt!.content,
                    style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                      color: ThemeManager.current.text_2,
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
              ],
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 30.w),
                Text("분위기", style: AppTextStyles.SejongGeulggot_16_regular),
                const Spacer(),
                SizedBox(
                  width: 280.w,
                  child: Text(
                    adminPromptViewModel.selectedPrompt!.mood,
                    style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                      color: ThemeManager.current.text_2,
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
              ],
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 30.w),
                Text("카테고리", style: AppTextStyles.SejongGeulggot_16_regular),
                const Spacer(),
                SizedBox(
                  width: 260.w,
                  child: Text(
                    displayCategoryTextFromString(
                        adminPromptViewModel.selectedPrompt!.category),
                    style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                      color: ThemeManager.current.text_2,
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
              ],
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 30.w),
                Text("소요시간", style: AppTextStyles.SejongGeulggot_16_regular),
                const Spacer(),
                SizedBox(
                  width: 260.w,
                  child: Text(
                    adminPromptViewModel.selectedPrompt!.readTime == "short"
                        ? StoryTime.short.displayText
                        : StoryTime.medium.displayText,
                    style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                      color: ThemeManager.current.text_2,
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
              ],
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 30.w),
                Text("말투", style: AppTextStyles.SejongGeulggot_16_regular),
                const Spacer(),
                SizedBox(
                  width: 260.w,
                  child: Text(
                    displayToneTextFromString(
                        adminPromptViewModel.selectedPrompt!.tone),
                    style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                      color: ThemeManager.current.text_2,
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
              ],
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 30.w),
                Text("프롬프트", style: AppTextStyles.SejongGeulggot_16_regular),
                const Spacer(),
                SizedBox(
                  width: 260.w,
                  child: Text(
                    adminPromptViewModel.selectedPrompt!.promptText,
                    style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                      color: ThemeManager.current.text_2,
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
