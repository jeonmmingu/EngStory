import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/fonts.dart';
import 'package:eng_story/core/utils/images.dart';
import 'package:eng_story/view_models/user/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AdminStoryListView extends StatelessWidget {
  const AdminStoryListView({super.key});

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(context),
                  _storyList(context),
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
                "스토리 관리",
                style: AppTextStyles.SejongGeulggot_22_regular,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              "생성된 스토리를 보거나, 삭제 하는 등 관리할 수 있는 페이지 입니다.",
              style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                color: ThemeManager.current.text_2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - storyList
  Widget _storyList(BuildContext context) {
    return FutureBuilder(
      future: context.read<HomeViewModel>().initializeApp(true),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Consumer<HomeViewModel>(
            builder: (context, value, child) => Expanded(
              child: ListView.builder(
                itemCount: context.read<HomeViewModel>().cachedStories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: _storyItem(context, index),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  // MARK: - storyItem
  Widget _storyItem(BuildContext context, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.heavyImpact();
            context.read<HomeViewModel>().setSelectedStory(
                  context.read<HomeViewModel>().cachedStories[index],
                );
            context.goNamed('storyDetail');
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ThemeManager.current.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ThemeManager.current.black, width: 0.3),
            ),
            child: Row(
              children: [
                Text(
                  context.read<HomeViewModel>().cachedStories[index].title,
                  style: AppTextStyles.SejongGeulggot_16_regular,
                ),
                const Spacer(),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
