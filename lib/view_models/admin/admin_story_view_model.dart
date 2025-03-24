import 'package:eng_story/core/tests/manage_story.dart';
import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/story_script.dart';
import 'package:flutter/material.dart';

class AdminStoryViewModel with ChangeNotifier {
  // 스크립트 index 개수
  int _scriptIndexCount = 1;
  int get scriptIndexCount => _scriptIndexCount;

  // Story Json String Data TextEditing Controller
  final TextEditingController storyJsonController = TextEditingController();

  // StoryScript Json String Data TextEditing Controller
  final List<TextEditingController> storyScriptJsonControllers = List.generate(
    8,
    (index) => TextEditingController(),
  );

  Story? _story;
  Story? get story => _story;

  final List<StoryScript> _storyScripts = [];
  List<StoryScript> get storyScripts => _storyScripts;

  // story editTextController에 입력값이 있는지 확인
  // _scriptIndexCount에 맞는 스크립트 입력값이 있는지 확인
  bool get inputValidation {
    if (storyJsonController.text.isEmpty) {
      return false;
    }
    for (int i = 0; i < _scriptIndexCount; i++) {
      if (storyScriptJsonControllers[i].text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  // textEditingController 변경 시, notifyListeners
  void textEditingControllerChanged() {
    notifyListeners();
  }

  // 스크립트 index 설정
  void setScriptIndexCount(int count) {
    _scriptIndexCount = count;
    notifyListeners();
  }

  // 스토리 및 스크립트 Firebase에 저장
  Future<void> saveStory() async {
    // 스토리 생성
    createStory();

    // 스토리 저장
    await ManageStory().addStory(_story!);

    // 스토리 스크립트 저장
    await ManageStory().addStoryScripts(_story!.id, _storyScripts);
  }

  // 스토리 생성
  void createStory() {
    _story = transformStoryFromJson(storyJsonController.text);
    for (int i = 0; i < _scriptIndexCount; i++) {
      _storyScripts.addAll(
          transformStoryScriptFromJson(storyScriptJsonControllers[i].text));
    }
  }

  Story transformStoryFromJson(String jsonString) {
    return Story.fromJson(jsonString);
  }

  List<StoryScript> transformStoryScriptFromJson(String jsonString) {
    return StoryScript.fromJsonList(jsonString);
  }
}
