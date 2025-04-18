import 'package:eng_story/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (_, context) {
        return Builder(
          builder: (context) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: MaterialApp.router(
                routerConfig: router,
                debugShowCheckedModeBanner: false,
              ),
            );
          },
        );
      },
    );
  }
}
