import 'package:eng_story/core/utils/colors.dart';
import 'package:eng_story/core/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

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

                  // Write Story Button
                  _writeStoryButton(context),

                  // story list button
                  _storyListButton(context),

                  // story list summation UI
                  _storyListSummationUI(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
          TextButton(
            onPressed: () {
              HapticFeedback.heavyImpact();
              debugPrint("유저 모드 전환 버튼 탭");
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black87),
            ),
            child: Text(
              "전환",
              style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _writeStoryButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      margin: EdgeInsets.only(
        top: 30.h,
        left: 30.w,
        right: 30.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 0.3),
      ),
      child: Center(
        child: Text(
          "Write Story",
          style: AppTextStyles.SejongGeulggot_16_regular,
        ),
      ),
    );
  }

  Widget _storyListButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.h,
      margin: EdgeInsets.only(
        top: 10.h,
        left: 30.w,
        right: 30.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 0.3),
      ),
      child: Center(
        child: Text(
          "Story List Manage Section",
          style: AppTextStyles.SejongGeulggot_16_regular,
        ),
      ),
    );
  }

  Widget _storyListSummationUI(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.h,
      margin: EdgeInsets.only(
        top: 10.h,
        left: 30.w,
        right: 30.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 0.3,
        ),
      ),
      child: Center(
        child: Text(
          "Story List Manage Section",
          style: AppTextStyles.SejongGeulggot_16_regular,
        ),
      ),
    );
  }
}
