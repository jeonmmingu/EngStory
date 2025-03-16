import 'package:eng_story/app.dart';
import 'package:eng_story/services/firebase_options.dart';
import 'package:eng_story/view_models/home_view_model.dart';
import 'package:eng_story/view_models/story_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';

Logger logger = Logger();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeViewModel()),
        ChangeNotifierProvider.value(value: StoryViewModel()),
      ],
      child: const App(),
    ),
  );
}
