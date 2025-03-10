import 'package:eng_story/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (_, context) => MaterialApp.router(
        // Go Router 설정
        routerConfig: router,
        debugShowCheckedModeBanner: false, // Debug 배너 없애기
      ),
    );
  }
}
