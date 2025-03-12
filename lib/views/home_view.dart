import 'package:eng_story/core/utils/animations.dart';
import 'package:eng_story/core/utils/colors.dart';
import 'package:eng_story/core/utils/fonts.dart';
import 'package:eng_story/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 178.h,
            ),
            Lottie.asset(
              AppAnimations.robot,
              width: 170.w,
              height: 170.h,
            ),
            SizedBox(height: 30.h),
            Text(
              "Hello, i'm EngBot",
              style: AppTextStyles.SejongGeulggot_20_regular.copyWith(
                color: AppColors.text_1,
              ),
            ),
            Text(
              "Choose a story what you want to read :)",
              style: AppTextStyles.SejongGeulggot_20_regular.copyWith(
                color: AppColors.text_1,
              ),
            ),
            SizedBox(height: 50.h),
            Image.asset(
              AppImages.diceButton,
              width: 100.w,
              height: 100.h,
            ),
          ],
        ),
      ),
    );
  }
}
