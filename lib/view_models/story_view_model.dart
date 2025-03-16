import 'package:eng_story/main.dart';
import 'package:eng_story/models/story_script.dart';
import 'package:eng_story/repositories/story_repository.dart';
import 'package:flutter/material.dart';

class StoryViewModel with ChangeNotifier {
  final StoryRepository _storyRepository = StoryRepository();

  final List<StoryScript> _selectedScripts = [];
  List<StoryScript> get selectedScripts => _selectedScripts;

  int _currentIdx = 0;
  int get currentIdx => _currentIdx;

  final List<StoryScript> _storyTellerScripts = [];
  List<StoryScript> get storyTellerScripts => _storyTellerScripts;

  final List<StoryScript> _meScripts = [];
  List<StoryScript> get meScripts => _meScripts;

  String languageMode = "Eng";

  void changeLanguageMode() {
    if (languageMode == "Eng") {
      languageMode = "Kor";
    } else {
      languageMode = "Eng";
    }
    notifyListeners();
  }

  Future<bool> getScripts(String storyId) async {
    try {
      resetAllStates();
      final scripts = await _storyRepository.readStoryScripts(storyId);
      _selectedScripts.addAll(scripts);
      return true;
    } catch (err) {
      logger.e("스토리 스크립트 가져오기 실패: $err");
      return false;
    }
  }

  void playStory() {
    if (_currentIdx == _selectedScripts.length) return;

    // 이전 스크립트의 역할이 me인 경우 다음 스크립트를 위해 다른 스크립트 지우기
    if (currentIdx != 0) {
      final beforeScript = getScript(_currentIdx);
      if (beforeScript.role == "me") {
        clearMeScripts();
        clearStoryTellerScripts();
      }
    }
    // 다음 스크립트 띄워주기
    _currentIdx++;
    final script = getScript(_currentIdx);
    if (script.role == "story_teller") {
      addStoryTellerScript(script);
    } else {
      addMeScript(script);
    }
    notifyListeners();
  }

  void rewindStory() {
    if (_currentIdx == 0) return;

    if (getScript(_currentIdx).role == "me") {
      removeMeScript();
      _currentIdx--;
    } else {
      if (storyTellerScripts.length != 1 || _currentIdx == 1) {
        removeStoryTellerScript();
        _currentIdx--;
      } else {
        removeStoryTellerScript();
        _currentIdx--;
        addMeScript(getScript(_currentIdx));
        var tmpIdx = _currentIdx - 1;
        print("tmpIdx: $tmpIdx");
        print("result: ${getScript(tmpIdx).role == "story_teller"}");
        while (getScript(tmpIdx).role == "story_teller") {
          print("In while tmpIdx: $tmpIdx");
          addStoryTellerScript(getScript(tmpIdx));
          tmpIdx--;
          if (tmpIdx == 0) break;
        }
        print("Out while tmpIdx: $tmpIdx");
        storyTellerScripts.sort((a, b) => a.index.compareTo(b.index));
      }
    }

    notifyListeners();
  }

  StoryScript getScript(int idx) {
    return _selectedScripts.where((element) => element.index == idx).first;
  }

  void addStoryTellerScript(StoryScript script) {
    _storyTellerScripts.add(script);
  }

  void removeStoryTellerScript() {
    _storyTellerScripts.removeLast();
  }

  void clearStoryTellerScripts() {
    _storyTellerScripts.clear();
  }

  void addMeScript(StoryScript script) {
    _meScripts.add(script);
  }

  void removeMeScript() {
    _meScripts.removeLast();
  }

  void clearMeScripts() {
    _meScripts.clear();
  }

  void resetAllStates() {
    _selectedScripts.clear();
    _currentIdx = 0;
    clearStoryTellerScripts();
    clearMeScripts();
  }
}
