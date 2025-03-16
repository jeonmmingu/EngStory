import 'package:eng_story/views/home_view.dart';
import 'package:eng_story/views/story_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'homeView',
      builder: (context, state) => const HomeView(),
      routes: [
        GoRoute(
          path: '/storyView',
          name: 'storyView',
          builder: (context, state) => const StoryView(),
        )
      ],
    ),
  ],
);
