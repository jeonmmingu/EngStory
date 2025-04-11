enum StoryTime {
  short, // 1~5 min
  medium, // 5~10 min
}

extension StoryTimeExtension on StoryTime {
  String get displayText {
    switch (this) {
      case StoryTime.short:
        return "1-5 분";
      case StoryTime.medium:
        return "5-10 분";
    }
  }

  String get typeText {
    switch (this) {
      case StoryTime.short:
        return "1-5 min";
      case StoryTime.medium:
        return "5-10 min";
      default:
        return "";
    }
  }
}
