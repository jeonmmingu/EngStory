import 'package:eng_story/view_models/home_view_model.dart';
import 'package:eng_story/view_models/story_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => HomeViewModel()),
    ChangeNotifierProvider(create: (_) => StoryViewModel()),
  ];
}