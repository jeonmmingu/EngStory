import 'package:eng_story/core/enums/story_category.dart';
import 'package:eng_story/core/enums/story_time.dart';
import 'package:eng_story/core/enums/story_tone.dart';
import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/fonts.dart';
import 'package:eng_story/core/utils/images.dart';
import 'package:eng_story/view_models/admin/admin_prompt_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AdminAddPromptView extends StatelessWidget {
  const AdminAddPromptView({super.key});

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
                color: Colors.blue[200],
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
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // header
                  _header(context, adminPromptViewModel),
                  SizedBox(height: 70.h),
                  // inputSection
                  _inputSection(context, adminPromptViewModel),
                  SizedBox(height: 30.h),
                  // 저장 버튼
                  _saveButton(context, adminPromptViewModel),
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
    return Column(
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
                adminPromptViewModel.resetAllStates();
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
              "prompt 생성",
              style: AppTextStyles.SejongGeulggot_22_regular,
            ),
          ],
        ),
        SizedBox(height: 30.h),
        Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Text(
            "제목, 주제, 카테고리, 소요시간, 말투, 분위기를 작성해주세요",
            style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
              color: ThemeManager.current.text_2,
            ),
          ),
        ),
      ],
    );
  }

  // MARK: - inputSection
  Widget _inputSection(
    BuildContext context,
    AdminPromptViewModel adminPromptViewModel,
  ) {
    return Column(
      children: [
        // 제목
        _titleInput(context, adminPromptViewModel),
        SizedBox(height: 20.h),
        // 주제
        _subjectInput(context, adminPromptViewModel),
        SizedBox(height: 20.h),
        // 분위기
        _moodInput(context, adminPromptViewModel),
        SizedBox(height: 25.h),
        // 카테고리
        _categoryInput(context, adminPromptViewModel),
        SizedBox(height: 25.h),
        // 소요시간
        _readTimeInput(context, adminPromptViewModel),
        SizedBox(height: 25.h),
        // 말투
        _toneInput(context, adminPromptViewModel),
        SizedBox(height: 25.h),
      ],
    );
  }

  // MARK: - titleInput
  Widget _titleInput(
    BuildContext context,
    AdminPromptViewModel adminPromptViewModel,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 30.w,
        ),
        SizedBox(
          width: 40.w,
          child: Text(
            "제목",
            style: AppTextStyles.SejongGeulggot_16_regular,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: TextField(
              controller: adminPromptViewModel.titleController,
              style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                color: ThemeManager.current.black,
              ),
              onChanged: (value) => context
                  .read<AdminPromptViewModel>()
                  .textEditingControllerChanged(),
            ),
          ),
        ),
        SizedBox(width: 30.w),
      ],
    );
  }

  // MARK: - subjectInput
  Widget _subjectInput(
    BuildContext context,
    AdminPromptViewModel adminPromptViewModel,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 30.w,
        ),
        SizedBox(
          width: 40.w,
          child: Text(
            "주제",
            style: AppTextStyles.SejongGeulggot_16_regular,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: TextField(
              controller: adminPromptViewModel.contentController,
              style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                color: ThemeManager.current.black,
              ),
              onChanged: (value) => context
                  .read<AdminPromptViewModel>()
                  .textEditingControllerChanged(),
            ),
          ),
        ),
        SizedBox(width: 30.w),
      ],
    );
  }

  // MARK: - moodInput
  Widget _moodInput(
    BuildContext context,
    AdminPromptViewModel adminPromptViewModel,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 30.w,
        ),
        SizedBox(
          width: 40.w,
          child: Text(
            "분위기",
            style: AppTextStyles.SejongGeulggot_16_regular,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: TextField(
              controller: adminPromptViewModel.moodController,
              style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                color: ThemeManager.current.black,
              ),
              onChanged: (value) => context
                  .read<AdminPromptViewModel>()
                  .textEditingControllerChanged(),
            ),
          ),
        ),
        SizedBox(width: 30.w),
      ],
    );
  }

  // MARK: - categoryInput
  Widget _categoryInput(
    BuildContext context,
    AdminPromptViewModel adminPromptViewModel,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 30.w,
        ),
        SizedBox(
          width: 60.w,
          child: Text(
            "카테고리",
            style: AppTextStyles.SejongGeulggot_16_regular,
          ),
        ),
        SizedBox(width: 30.w),
        SizedBox(
          height: 50.h,
          width: 100.w,
          child: DropdownButton(
            menuMaxHeight: 300.h,
            style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
              color: ThemeManager.current.black,
            ),
            value: adminPromptViewModel.category == null
                ? null
                : displayCategoryText(adminPromptViewModel.category!),
            isExpanded: true,
            items: getAllCategoryDisplayTexts()
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              final category = StoryCategory.values.firstWhere(
                (e) => displayCategoryText(e) == value,
              );
              adminPromptViewModel.setCategory(category);
            },
          ),
        )
      ],
    );
  }

  // MARK: - readTimeInput
  Widget _readTimeInput(
    BuildContext context,
    AdminPromptViewModel adminPromptViewModel,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 30.w,
        ),
        SizedBox(
          width: 60.w,
          child: Text(
            "소요시간",
            style: AppTextStyles.SejongGeulggot_16_regular,
          ),
        ),
        SizedBox(width: 30.w),
        SizedBox(
          height: 50.h,
          width: 100.w,
          child: DropdownButton(
            menuMaxHeight: 300.h,
            style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
              color: ThemeManager.current.black,
            ),
            value: adminPromptViewModel.readTime?.displayText,
            isExpanded: true,
            items: StoryTime.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e.displayText,
                    child: Text(e.displayText),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              final readTime = StoryTime.values.firstWhere(
                (e) => e.displayText == value,
              );
              adminPromptViewModel.setReadTime(readTime);
            },
          ),
        )
      ],
    );
  }

  // MARK: - toneInput
  Widget _toneInput(
    BuildContext context,
    AdminPromptViewModel adminPromptViewModel,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 30.w,
        ),
        SizedBox(
          width: 60.w,
          child: Text(
            "말투",
            style: AppTextStyles.SejongGeulggot_16_regular,
          ),
        ),
        SizedBox(width: 30.w),
        SizedBox(
          height: 50.h,
          width: 250.w,
          child: DropdownButton(
            menuMaxHeight: 300.h,
            style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
              color: ThemeManager.current.black,
            ),
            value: adminPromptViewModel.tone == null
                ? null
                : displayToneText(adminPromptViewModel.tone!),
            isExpanded: true,
            items: getAllToneDisplayTexts()
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              final tone = StoryTone.values.firstWhere(
                (e) => displayToneText(e) == value,
              );
              adminPromptViewModel.setTone(tone);
            },
          ),
        )
      ],
    );
  }

  // MARK: - saveButton
  Widget _saveButton(
    BuildContext context,
    AdminPromptViewModel adminPromptViewModel,
  ) {
    return GestureDetector(
      onTap: () {
        if (adminPromptViewModel.checkSaveValidation == false) {
          return;
        }
        // 저장 버튼 클릭 시
        // prompt 생성 API 호출
        try {
          adminPromptViewModel.savePrompt();
          adminPromptViewModel.resetAllStates();
          context.pop();
        } catch (error) {
          // 에러 발생 시, 에러 메시지 출력
          debugPrint("❌ prompt 생성 실패: $error");
          // 하단에 snackBar 보여주기. 검정 배경에 하얀 글씨
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "prompt 생성에 실패했습니다. 다시 시도해주세요.",
                style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                  color: ThemeManager.current.white,
                ),
              ),
              backgroundColor: ThemeManager.current.black,
            ),
          );
        }
      },
      child: Center(
        child: Container(
          width: 200.w,
          height: 50.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: adminPromptViewModel.checkSaveValidation == true
                ? Colors.blue[200]
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            "저장",
            style: AppTextStyles.SejongGeulggot_18_regular.copyWith(
              color: adminPromptViewModel.checkSaveValidation == true
                  ? ThemeManager.current.black
                  : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
