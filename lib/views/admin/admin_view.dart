import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/font/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

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
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _header(context),
                  SizedBox(height: 10.h),
                  // Write Story Button
                  _writeStoryButton(context),
                  SizedBox(height: 10.h),
                  // story list button
                  Row(
                    children: [
                      _promptListButton(context),
                      // story list summation UI
                      const Spacer(),
                      _storyListButton(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - header
  Widget _header(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            "관리자 페이지",
            style: FontManager.current.font_24,
          ),
        ],
      ),
    );
  }

  // MARK: - writeStoryButton
  Widget _writeStoryButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.heavyImpact();
        debugPrint("writeStoryButton tapped");
        context.goNamed('addPrompt');
      },
      child: Container(
        width: 393.w,
        height: 100.h,
        margin: EdgeInsets.only(
          top: 30.h,
          left: 30.w,
          right: 30.w,
        ),
        decoration: BoxDecoration(
          color: ThemeManager.current.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: ThemeManager.current.black, width: 0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20.w),
            Text(
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              "새로운 이야기 프롬프트 생성",
              style: FontManager.current.font_16,
            ),
            const Spacer(),
            const Icon(Icons.chevron_right),
            SizedBox(width: 20.w),
          ],
        ),
      ),
    );
  }

  // MARK: - promptListButton
  Widget _promptListButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.heavyImpact();
        context.goNamed('promptList');
      },
      child: Container(
        width: 155.w,
        height: 110.h,
        margin: EdgeInsets.only(
          top: 10.h,
          left: 30.w,
        ),
        decoration: BoxDecoration(
          color: ThemeManager.current.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: ThemeManager.current.black, width: 0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20.w),
            Text(
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              "프롬프트",
              style: FontManager.current.font_16,
            ),
            const Spacer(),
            const Icon(Icons.chevron_right),
            SizedBox(width: 20.w),
          ],
        ),
      ),
    );
  }

  // MARK: - storyListButton
  Widget _storyListButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.heavyImpact();
        context.goNamed('storyList');
      },
      child: Container(
        width: 155.w,
        height: 110.h,
        margin: EdgeInsets.only(
          top: 10.h,
          right: 30.w,
        ),
        decoration: BoxDecoration(
          color: ThemeManager.current.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: ThemeManager.current.black,
            width: 0.3,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20.w),
            Text(
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              "스토리",
              style: FontManager.current.font_16,
            ),
            const Spacer(),
            const Icon(Icons.chevron_right),
            SizedBox(width: 20.w),
          ],
        ),
      ),
    );
  }
}
