import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/font/font_manager.dart';
import 'package:eng_story/core/utils/images.dart';
import 'package:eng_story/view_models/admin/admin_story_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AdminAddStoryView extends StatelessWidget {
  const AdminAddStoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final adminStoryViewModel = Provider.of<AdminStoryViewModel>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                    _header(context, adminStoryViewModel),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            _storyJsonInput(context),
                            SizedBox(height: 20.h),
                            _storyScriptJsonInput(context),
                            SizedBox(height: 20.h),
                            _createStoryButton(context, adminStoryViewModel),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
    AdminStoryViewModel adminStoryViewModel,
  ) {
    return SizedBox(
      height: 80.h, // 높이 조정
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 20.w),
          GestureDetector(
            onTap: () {
              context.pop();
              adminStoryViewModel.resetAllStates();
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
            "스토리 추가",
            style: FontManager.current.font_22,
          ),
        ],
      ),
    );
  }

  // MARK: - Story Json String Input Section
  Widget _storyJsonInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Story Json Script",
            style: FontManager.current.font_16,
          ),
          SizedBox(height: 10.h),
          Container(
            width: 393.w,
            height: 200.h,
            decoration: BoxDecoration(
              color: ThemeManager.current.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: ThemeManager.current.black, width: 0.3),
            ),
            child: TextField(
              maxLines: 10,
              controller:
                  context.read<AdminStoryViewModel>().storyJsonController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide:
                      BorderSide(color: ThemeManager.current.black, width: 0.3),
                ),
                contentPadding: const EdgeInsets.all(20),
              ),
              onChanged: (value) => context
                  .read<AdminStoryViewModel>()
                  .textEditingControllerChanged(),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - StoryScript Json String Input Section
  Widget _storyScriptJsonInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "StoryScript Json Array",
            style: FontManager.current.font_16,
          ),
          SizedBox(height: 10.h),
          Container(
            width: 393.w,
            height: 400.h, // 높이를 더 크게 설정
            decoration: BoxDecoration(
              color: ThemeManager.current.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: ThemeManager.current.black, width: 0.3),
            ),
            child: TextField(
              maxLines: 20, // 더 많은 라인 입력 가능
              controller:
                  context.read<AdminStoryViewModel>().storyScriptJsonController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide:
                      BorderSide(color: ThemeManager.current.black, width: 0.3),
                ),
                contentPadding: const EdgeInsets.all(20),
              ),
              onChanged: (value) => context
                  .read<AdminStoryViewModel>()
                  .textEditingControllerChanged(),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - Create Story Button
  Widget _createStoryButton(
    BuildContext context,
    AdminStoryViewModel adminStoryViewModel,
  ) {
    bool inputValidation = adminStoryViewModel.inputValidation;
    return GestureDetector(
      onTap: () async {
        HapticFeedback.heavyImpact();
        if (!inputValidation) {
          return;
        }
        // 객체 생성 후 저장
        await adminStoryViewModel.saveStory();
        context.pop();
      },
      child: Container(
        height: 60.h,
        width: 200.w,
        decoration: BoxDecoration(
          color:
              inputValidation ? ThemeManager.current.grey_2 : Colors.grey[400],
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: ThemeManager.current.black, width: 0.1),
        ),
        alignment: Alignment.center,
        child: Text(
          "스토리 생성",
          style: FontManager.current.font_16.copyWith(
            color: ThemeManager.current.white,
          ),
        ),
      ),
    );
  }
}
