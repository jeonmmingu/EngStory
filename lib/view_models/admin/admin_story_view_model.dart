import 'package:eng_story/core/tests/manage_story.dart';
import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/story_script.dart';
import 'package:flutter/material.dart';

class AdminStoryViewModel with ChangeNotifier {
  // Story Json String Data TextEditing Controller
  final TextEditingController storyJsonController = TextEditingController();

  // 단일 StoryScript Json String Data TextEditing Controller
  final TextEditingController storyScriptJsonController =
      TextEditingController(); // 하나로 통합

  Story? _story;
  Story? get story => _story;

  final List<StoryScript> _storyScripts = [];
  List<StoryScript> get storyScripts => _storyScripts;

  bool get inputValidation {
    return storyJsonController.text.isNotEmpty &&
        storyScriptJsonController.text.isNotEmpty;
  }

  void textEditingControllerChanged() {
    notifyListeners();
  }

  Future<void> saveStory() async {
    createStory();
    await ManageStory().addStory(_story!);
    await ManageStory().addStoryScripts(_story!.id, _storyScripts);
  }

  void createStory() {
    _story = transformStoryFromJson(storyJsonController.text);
    _storyScripts
        .addAll(transformStoryScriptFromJson(storyScriptJsonController.text));
  }

  Story transformStoryFromJson(String jsonString) {
    return Story.fromJson(jsonString);
  }

  List<StoryScript> transformStoryScriptFromJson(String jsonString) {
    return StoryScript.fromJsonList(jsonString);
  }

  void resetAllStates() {
    storyJsonController.clear();
    storyScriptJsonController.clear();
    _story = null;
    _storyScripts.clear();
  }
}
