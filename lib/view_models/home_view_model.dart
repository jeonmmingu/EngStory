import 'package:eng_story/core/enums/story_time.dart';
import 'package:eng_story/models/story.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  StoryTime _storyTime = StoryTime.short;
  StoryTime get storyTime => _storyTime;

  Story? _selectedStory;
  Story? get selectedStory => _selectedStory;

  void setStoryTime(StoryTime storyTime) {
    _storyTime = storyTime;
    notifyListeners();
  }

  void setSelectedStory(Story story) {
    _selectedStory = story;
    notifyListeners();
  }
}
