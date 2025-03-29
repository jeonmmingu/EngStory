import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/fonts.dart';
import 'package:eng_story/core/utils/images.dart';
import 'package:eng_story/view_models/admin/admin_prompt_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AdminPromptListView extends StatelessWidget {
  const AdminPromptListView({super.key});

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
                  _header(context),
                  _promptList(context),
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
                "프롬프트 관리",
                style: AppTextStyles.SejongGeulggot_22_regular,
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Text(
              "프롬프트를 이용해서 스토리를 만들거나, 수정, 삭제 할 수 있습니다.",
              style: AppTextStyles.SejongGeulggot_16_regular.copyWith(
                color: ThemeManager.current.text_2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - promptList
  Widget _promptList(BuildContext context) {
    return FutureBuilder(
      future: context.read<AdminPromptViewModel>().getPromptList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Consumer<AdminPromptViewModel>(
            builder: (context, value, child) => Expanded(
              child: ListView.builder(
                itemCount:
                    context.read<AdminPromptViewModel>().promptList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.goNamed('promptDetail');
                      context.read<AdminPromptViewModel>().selectPrompt(
                            context
                                .read<AdminPromptViewModel>()
                                .promptList[index],
                          );
                    },
                    child: _promptItem(context, index),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  // MARK: - promptItem
  Widget _promptItem(BuildContext context, int index) {
    return Column(
      children: [
        Container(
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
                context.read<AdminPromptViewModel>().promptList[index].title,
                style: AppTextStyles.SejongGeulggot_16_regular,
              ),
              const Spacer(),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ],
    );
  }
}
