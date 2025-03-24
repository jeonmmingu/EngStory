import 'package:eng_story/core/utils/colors.dart';
import 'package:eng_story/core/utils/fonts.dart';
import 'package:eng_story/services/local/device_info_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

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
            decoration: const BoxDecoration(color: AppColors.background),
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
            "관리자 페이지",
            style: AppTextStyles.SejongGeulggot_24_regular,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              HapticFeedback.heavyImpact();
              debugPrint("유저 모드 전환 버튼 탭");
              DeviceInfoManager().isDeviceManagerChecked = false;
              DeviceInfoManager().adminMode = false;
              context.go('/');
            },
            child: Container(
              width: 50.w,
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20.w),
            Text(
              "새로운 이야기 프롬프트 생성",
              style: AppTextStyles.SejongGeulggot_16_regular,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.black, width: 0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20.w),
            Text(
              "프롬프트",
              style: AppTextStyles.SejongGeulggot_16_regular,
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Colors.black,
            width: 0.3,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 20.w),
            Text(
              "스토리",
              style: AppTextStyles.SejongGeulggot_16_regular,
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
