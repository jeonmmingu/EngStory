import 'package:eng_story/views/admin/admin_add_prompt_view.dart';
import 'package:eng_story/views/admin/admin_add_story_view.dart';
import 'package:eng_story/views/admin/admin_prompt_detail_view.dart';
import 'package:eng_story/views/admin/admin_prompt_list_view.dart';
import 'package:eng_story/views/admin/admin_story_detail_view.dart';
import 'package:eng_story/views/admin/admin_story_list_view.dart';
import 'package:eng_story/views/admin/admin_view.dart';
import 'package:eng_story/views/user/home_view.dart';
import 'package:eng_story/views/user/story_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/', // 기본 경로 (redirect에서 변경됨)
  // redirect: (context, state) {
  //   if (!DeviceInfoManager().isDeviceManagerChecked) {
  //     DeviceInfoManager().isDeviceManagerChecked = true;
  //     final bool isAdmin = DeviceInfoManager().isAdmin();
  //     final bool adminMode = DeviceInfoManager().adminMode;
  //     return isAdmin && adminMode ? '/adminView' : '/';
  //   } else {
  //     return null;
  //   }
  // },
  routes: [
    GoRoute(
      path: '/',
      name: 'homeView',
      builder: (context, state) => const HomeView(),
      routes: [
        GoRoute(
          path: 'storyView',
          name: 'storyView',
          builder: (context, state) => const StoryView(),
        ),
      ],
    ),
    GoRoute(
      path: '/adminView',
      name: 'adminView',
      builder: (context, state) => const AdminView(),
      routes: [
        GoRoute(
          path: 'addPrompt',
          name: 'addPrompt',
          builder: (context, state) => const AdminAddPromptView(),
        ),
        GoRoute(
          path: 'promptList',
          name: 'promptList',
          builder: (context, state) => const AdminPromptListView(),
          routes: [
            GoRoute(
              path: 'promptDetail',
              name: 'promptDetail',
              builder: (context, state) => const AdminPromptDetailView(),
              routes: [
                GoRoute(
                  path: 'addStory',
                  name: 'addStory',
                  builder: (context, state) => const AdminAddStoryView(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: 'storyList',
          name: 'storyList',
          builder: (context, state) => const AdminStoryListView(),
          routes: [
            GoRoute(
              path: 'storyDetail',
              name: 'storyDetail',
              builder: (context, state) => const AdminStoryDetailView(),
            ),
          ],
        ),
      ],
    ),
  ],
);
