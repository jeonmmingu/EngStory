import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/fonts.dart';
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
              decoration:
                  BoxDecoration(color: ThemeManager.current.background),
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
                            ...List.generate(
                              adminStoryViewModel.scriptIndexCount,
                              (index) => Column(
                                children: [
                                  SizedBox(height: 20.h),
                                  _storyScriptJsonInput(context, index + 1),
                                ],
                              ),
                            ),
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
                "스토리 추가",
                style: AppTextStyles.SejongGeulggot_22_regular,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "스크립트 index 개수:",
                  style: AppTextStyles.SejongGeulggot_18_regular,
                ),
                SizedBox(width: 20.w),
                Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: ThemeManager.current.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                        color: ThemeManager.current.black, width: 0.3),
                  ),
                  child: DropdownButton<int>(
                    value: adminStoryViewModel.scriptIndexCount,
                    items: List.generate(
                      8,
                      (index) => DropdownMenuItem(
                        value: index + 1,
                        child: Text(
                          (index + 1).toString(),
                          style: AppTextStyles.SejongGeulggot_16_regular,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      // Handle dropdown value change
                      adminStoryViewModel.setScriptIndexCount(value!);
                    },
                    underline: const SizedBox(),
                  ),
                ),
              ],
            ),
          )
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
            style: AppTextStyles.SejongGeulggot_16_regular,
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
                    borderSide: BorderSide(
                        color: ThemeManager.current.black, width: 0.3),
                  ),
                  contentPadding: EdgeInsets.only(
                    top: 20.h,
                    bottom: 20.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                ),
                onChanged: (value) => context
                    .read<AdminStoryViewModel>()
                    .textEditingControllerChanged()),
          ),
        ],
      ),
    );
  }

  // MARK: - StoryScript Json String Input Section
  Widget _storyScriptJsonInput(BuildContext context, int index) {
    final start = (index - 1) * 20 + 1;
    final end = index * 20;
    final title = "StoryScript Json Script ($start~$end)";
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.SejongGeulggot_16_regular,
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
                controller: context
                    .read<AdminStoryViewModel>()
                    .storyScriptJsonControllers[index - 1],
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide(
                        color: ThemeManager.current.black, width: 0.3),
                  ),
                  contentPadding: EdgeInsets.only(
                    top: 20.h,
                    bottom: 20.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                ),
                onChanged: (value) => context
                    .read<AdminStoryViewModel>()
                    .textEditingControllerChanged()),
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
          color: inputValidation ? Colors.blue[200] : Colors.grey[400],
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: ThemeManager.current.black, width: 0.1),
        ),
        alignment: Alignment.center,
        child: Text(
          "스토리 생성",
          style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
            color: ThemeManager.current.white,
          ),
        ),
      ),
    );
  }
}
