import 'package:eng_story/core/enums/story_category.dart';
import 'package:eng_story/core/enums/story_time.dart';
import 'package:eng_story/core/enums/story_tone.dart';
import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/font/font_manager.dart';
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
                  child: Image.asset(
                    AppImages.backButton,
                    color: ThemeManager.current.text_1,
                  ),
                ),
              ),
              SizedBox(width: 18.w),
              Text(
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                adminPromptViewModel.selectedPrompt!.title,
                style: FontManager.current.font_22,
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
                        content: Text(
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            "프롬프트 삭제에 실패했습니다. ($e)"),
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
                      content: Text(
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          "클립보드에 복사되었습니다!"),
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
                Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "제목",
                    style: FontManager.current.font_16),
                const Spacer(),
                SizedBox(
                  width: 280.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    adminPromptViewModel.selectedPrompt!.title,
                    style: FontManager.current.font_16.copyWith(
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
                Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "주제",
                    style: FontManager.current.font_16),
                const Spacer(),
                SizedBox(
                  width: 280.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    adminPromptViewModel.selectedPrompt!.content,
                    style: FontManager.current.font_16.copyWith(
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
                Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "분위기",
                    style: FontManager.current.font_16),
                const Spacer(),
                SizedBox(
                  width: 280.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    adminPromptViewModel.selectedPrompt!.mood,
                    style: FontManager.current.font_16.copyWith(
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
                Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "카테고리",
                    style: FontManager.current.font_16),
                const Spacer(),
                SizedBox(
                  width: 260.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    displayCategoryTextFromString(
                        adminPromptViewModel.selectedPrompt!.category),
                    style: FontManager.current.font_16.copyWith(
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
                Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "소요시간",
                    style: FontManager.current.font_16),
                const Spacer(),
                SizedBox(
                  width: 260.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    adminPromptViewModel.selectedPrompt!.readTime == "short"
                        ? StoryTime.short.displayText
                        : StoryTime.medium.displayText,
                    style: FontManager.current.font_16.copyWith(
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
                Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "말투",
                    style: FontManager.current.font_16),
                const Spacer(),
                SizedBox(
                  width: 260.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    displayToneTextFromString(
                        adminPromptViewModel.selectedPrompt!.tone),
                    style: FontManager.current.font_16.copyWith(
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
                Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    "프롬프트",
                    style: FontManager.current.font_16),
                const Spacer(),
                SizedBox(
                  width: 260.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    adminPromptViewModel.selectedPrompt!.promptText,
                    style: FontManager.current.font_16.copyWith(
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
