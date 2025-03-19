import 'package:eng_story/services/local/device_info_manager.dart';
import 'package:eng_story/views/admin_view.dart';
import 'package:eng_story/views/home_view.dart';
import 'package:eng_story/views/story_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/', // 기본 경로 (redirect에서 변경됨)
  redirect: (context, state) {
    final bool isAdmin = DeviceInfoManager().isAdmin();
    return isAdmin ? '/adminView' : '/';
  },
  routes: [
    GoRoute(
      path: '/',
      name: 'homeView',
      builder: (context, state) => const HomeView(),
      routes: [
        GoRoute(
          path: 'storyView', // '/' 제거 (중첩 라우트에서는 상대 경로)
          name: 'storyView',
          builder: (context, state) => const StoryView(),
        ),
      ],
    ),
    GoRoute(
      path: '/adminView',
      name: 'adminView',
      builder: (context, state) => const AdminView(),
    ),
  ],
);
