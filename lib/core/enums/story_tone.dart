enum StoryTone {
  documentaryHost,
  highSchoolTeacher,
  warmMother,
  quietStoryteller,
  adventurousExplorer,
  emotionalActor,
  calmProfessor,
  playfulFriend,
  spookyGhostTeller,
  whisperingVoice,
  energeticYoutuber,
  logicalHistorian,
}

// enum → 한글 텍스트
String displayToneText(StoryTone tone) {
  switch (tone) {
    case StoryTone.documentaryHost:
      return '다큐멘터리를 진행하는 진행자 말투';
    case StoryTone.highSchoolTeacher:
      return '학생들에게 설명해주는 고등학교 선생님 말투';
    case StoryTone.warmMother:
      return '어린아이에게 읽어주는 따뜻한 엄마 말투';
    case StoryTone.quietStoryteller:
      return '비밀스럽고 조용한 이야기꾼 말투';
    case StoryTone.adventurousExplorer:
      return '흥미진진하게 들려주는 모험가 말투';
    case StoryTone.emotionalActor:
      return '감정을 담아 연기하듯 말하는 배우 말투';
    case StoryTone.calmProfessor:
      return '차분하고 지적인 교수 말투';
    case StoryTone.playfulFriend:
      return '친근하고 장난기 있는 친구 말투';
    case StoryTone.spookyGhostTeller:
      return '무섭고 음산한 분위기의 괴담 말투';
    case StoryTone.whisperingVoice:
      return '속삭이듯 조용한 말투';
    case StoryTone.energeticYoutuber:
      return '빠르고 에너지 넘치는 유튜버 말투';
    case StoryTone.logicalHistorian:
      return '역사적 사실을 논리적으로 설명하는 학자 말투';
  }
}

// String(enum name) → 한글 변환
String displayToneTextFromString(String toneName) {
  try {
    final tone = StoryTone.values.firstWhere(
      (e) => e.name == toneName,
      orElse: () => throw ArgumentError('Invalid tone name'),
    );
    return displayToneText(tone);
  } catch (e) {
    return '알 수 없음';
  }
}

// 전체 한글 말투 리스트
List<String> getAllToneDisplayTexts() {
  return StoryTone.values.map(displayToneText).toList();
}