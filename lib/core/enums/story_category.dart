enum StoryCategory {
  scienceExploration,
  horror,
  myth,
  animalStory,
  fairyTale,
  fable,
  legend,
  folklore,
  adventure,
  mystery,
  fantasy,
  romance,
  drama,
  historical,
  moralStory,
  detective,
  crime,
  friendship,
  family,
  comingOfAge,
  finance,
}

// 카테고리 enum → 한글 변환
String displayCategoryText(StoryCategory? category) {
  if (category == null) return 'null';
  switch (category) {
    case StoryCategory.scienceExploration:
      return '과학 탐험';
    case StoryCategory.horror:
      return '공포';
    case StoryCategory.myth:
      return '신화';
    case StoryCategory.animalStory:
      return '동물 이야기';
    case StoryCategory.fairyTale:
      return '동화';
    case StoryCategory.fable:
      return '우화';
    case StoryCategory.legend:
      return '전설';
    case StoryCategory.folklore:
      return '민담';
    case StoryCategory.adventure:
      return '모험';
    case StoryCategory.mystery:
      return '미스터리';
    case StoryCategory.fantasy:
      return '판타지';
    case StoryCategory.romance:
      return '로맨스';
    case StoryCategory.drama:
      return '드라마';
    case StoryCategory.historical:
      return '역사';
    case StoryCategory.moralStory:
      return '교훈적 이야기';
    case StoryCategory.detective:
      return '탐정';
    case StoryCategory.crime:
      return '범죄';
    case StoryCategory.friendship:
      return '우정';
    case StoryCategory.family:
      return '가족';
    case StoryCategory.comingOfAge:
      return '성장 이야기';
    case StoryCategory.finance:
      return '경제';
  }
}

// String(enum name) → 한글 변환
String displayCategoryTextFromString(String categoryName) {
  try {
    final category = StoryCategory.values.firstWhere(
      (e) => e.name == categoryName,
      orElse: () => throw ArgumentError('Invalid category name'),
    );
    return displayCategoryText(category);
  } catch (e) {
    return '알 수 없음';
  }
}

// 전체 한글 카테고리 리스트 반환
List<String> getAllCategoryDisplayTexts() {
  return StoryCategory.values.map(displayCategoryText).toList();
}
