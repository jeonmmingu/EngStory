import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/story_script.dart';

/// 📌 어린 왕자 스토리 더미 데이터
final Story dummyStoryLittlePrince = Story(
  id: "little_prince_01",
  title: "The Little Prince",
  source: "Public Domain",
  category: "Fairy Tale",
  readTime: "1-5 min",
  updatedAt: Timestamp.now(),
);

/// 📌 어린 왕자 스크립트 더미 데이터
final List<StoryScript> dummyScriptsLittlePrince = [
  StoryScript(
    id: "script_01",
    storyId: "little_prince_01",
    index: 1,
    role: "story_teller",
    text_en: "One day, a little prince appeared before a pilot stranded in the desert.",
    text_ko: "어느 날, 사막에 고립된 조종사 앞에 어린 왕자가 나타났어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "script_02",
    storyId: "little_prince_01",
    index: 2,
    role: "me",
    text_en: "Who... Who are you?",
    text_ko: "누... 누구니?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "script_03",
    storyId: "little_prince_01",
    index: 3,
    role: "story_teller",
    text_en: "The little prince smiled and said, 'Please, draw me a sheep.'",
    text_ko: "어린 왕자는 미소를 지으며 말했어요. '양을 한 마리 그려줘.'",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "script_04",
    storyId: "little_prince_01",
    index: 4,
    role: "me",
    text_en: "A sheep? Why do you need a sheep?",
    text_ko: "양? 왜 양이 필요하니?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "script_05",
    storyId: "little_prince_01",
    index: 5,
    role: "story_teller",
    text_en: "The little prince looked serious. 'Because my planet is very small, and the sheep will help keep the baobabs away.'",
    text_ko: "어린 왕자는 진지한 표정으로 말했어요. '내 별은 아주 작아서 양이 바오밥 나무가 자라는 걸 막아줄 거야.'",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "script_06",
    storyId: "little_prince_01",
    index: 6,
    role: "me",
    text_en: "Your planet? Where are you from?",
    text_ko: "너의 별? 넌 어디에서 왔니?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "script_07",
    storyId: "little_prince_01",
    index: 7,
    role: "story_teller",
    text_en: "The little prince pointed to the sky and whispered, 'I come from a tiny planet called Asteroid B-612.'",
    text_ko: "어린 왕자는 하늘을 가리키며 속삭였어요. '나는 B-612라는 아주 작은 별에서 왔어.'",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "script_08",
    storyId: "little_prince_01",
    index: 8,
    role: "me",
    text_en: "That sounds fascinating!",
    text_ko: "정말 신기하구나!",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "script_09",
    storyId: "little_prince_01",
    index: 9,
    role: "story_teller",
    text_en: "The little prince laughed softly. 'Grown-ups never understand anything by themselves. They always need explanations.'",
    text_ko: "어린 왕자는 조용히 웃었어요. '어른들은 스스로 아무것도 이해하지 못해. 언제나 설명이 필요하지.'",
    updatedAt: Timestamp.now(),
  ),
];