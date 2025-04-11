import 'package:eng_story/view_models/admin/admin_prompt_view_model.dart';
import 'package:eng_story/view_models/admin/admin_story_view_model.dart';
import 'package:eng_story/view_models/user/home_view_model.dart';
import 'package:eng_story/view_models/user/story_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ChangeNotifierProvider(create: (_) => StoryViewModel()),
    ChangeNotifierProvider(create: (_) => AdminPromptViewModel()),
    ChangeNotifierProvider(create: (_) => AdminStoryViewModel()),
  ];
}
