// ignore_for_file: use_build_context_synchronously

import 'package:eng_story/core/tests/manage_story.dart';
import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/font/font_manager.dart';
import 'package:eng_story/core/utils/images.dart';
import 'package:eng_story/view_models/user/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AdminStoryDetailView extends StatelessWidget {
  const AdminStoryDetailView({super.key});

  // MARK: - build
  @override
  Widget build(BuildContext context) {
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
              child: Consumer<HomeViewModel>(
                builder: (context, value, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(context),
                    if (context.read<HomeViewModel>().isDeleting != true)
                      _storyInfoSection(context),
                    if (context.read<HomeViewModel>().isDeleting == true)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - header
  Widget _header(BuildContext context) {
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
                context.read<HomeViewModel>().selectedStory!.title,
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
                    Icons.indeterminate_check_box_rounded,
                    size: 30.h,
                    color: ThemeManager.current.grey_1,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
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
                    Icons.indeterminate_check_box_rounded,
                    size: 30.h,
                    color: ThemeManager.current.grey_1,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  if (context.read<HomeViewModel>().isDeleting == true) return;

                  HapticFeedback.heavyImpact();
                  try {
                    // homeViewModel 의 isDeleting 상태 변경
                    context.read<HomeViewModel>().setIsDeleting(true);
                    await ManageStory().softDeleteStory(
                      context.read<HomeViewModel>().selectedStory!.id,
                    );
                    await context.read<HomeViewModel>().deleteCachedStory(
                          context.read<HomeViewModel>().selectedStory!.id,
                        );
                    context.read<HomeViewModel>().setIsDeleting(false);
                    context.pop();
                    // 스토리 삭제 완료 알림 snackBar 띄우기
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            "스토리가 삭제되었습니다."),
                      ),
                    );
                  } catch (e) {
                    debugPrint("❌ 스토리 삭제 실패: $e");
                    context.read<HomeViewModel>().setIsDeleting(false);
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
                    color: context.read<HomeViewModel>().isDeleting == true
                        ? ThemeManager.current.grey_1
                        : ThemeManager.current.button,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
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
                    Icons.indeterminate_check_box_rounded,
                    size: 26.h,
                    color: ThemeManager.current.grey_1,
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

  // MARK: - storyInfoSection
  Widget _storyInfoSection(
    BuildContext context,
  ) {
    final story = context.read<HomeViewModel>().selectedStory!;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
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
                  width: 240.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    story.title,
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
                  width: 240.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    story.category,
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
                  width: 240.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    story.readTime,
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
                    "출처",
                    style: FontManager.current.font_16),
                const Spacer(),
                SizedBox(
                  width: 240.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    story.source,
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
                    "생성일자",
                    style: FontManager.current.font_16),
                const Spacer(),
                SizedBox(
                  width: 240.w,
                  child: Text(
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    story.updatedAt.toString(),
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
