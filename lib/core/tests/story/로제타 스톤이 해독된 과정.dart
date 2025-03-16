import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/story_script.dart';

/// 📌 역사: 로제타 스톤이 해독된 과정
final Story dummyStoryRosetta = Story(
  id: "rosetta_decipher",
  title: "로제타 스톤이 해독된 과정",
  source: "Historical Documents",
  category: "history",
  readTime: "10-15 min",
  updatedAt: Timestamp.now(),
);

/// 각 회차별 스토리 텔러(역사학자)와 학생(me)의 대화 스크립트
/// - 각 회차는 스토리 텔러의 설명(1~3문장) → 학생의 질문 → 스토리 텔러의 답변 형식으로 구성되어 있습니다.
/// - 총 8회차로 구성되어 있으며, 전체 스크립트 개수는 32개입니다.
final List<StoryScript> dummyRosettaScripts = [
  // Cycle 1
  StoryScript(
    id: "로제타스톤_1",
    storyId: dummyStoryRosetta.title,
    index: 1,
    role: "story_teller",
    text_en:
        "The Rosetta Stone was discovered in 1799 by French soldiers in Egypt. It amazed historians because it carried the same text in three different scripts.",
    text_ko:
        "로제타 스톤은 1799년 이집트에서 프랑스 군인들에 의해 발견되었어요. 세 가지 다른 문자로 같은 내용이 쓰여 있어 역사학자들을 놀라게 했죠.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_2",
    storyId: dummyStoryRosetta.title,
    index: 2,
    role: "story_teller",
    text_en:
        "This artifact was special because it offered a unique key to understanding ancient Egyptian writing.",
    text_ko:
        "이 유물은 고대 이집트 문자 해독의 열쇠가 될 수 있다는 점에서 매우 특별했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_3",
    storyId: dummyStoryRosetta.title,
    index: 3,
    role: "me",
    text_en: "Teacher, why was the stone so special?",
    text_ko: "선생님, 그 돌은 왜 그렇게 특별했나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_4",
    storyId: dummyStoryRosetta.title,
    index: 4,
    role: "story_teller",
    text_en:
        "Because it bore the same decree in hieroglyphics, demotic, and Greek – letting scholars compare and unlock the meaning of ancient Egyptian symbols.",
    text_ko:
        "왜냐하면, 동일한 내용의 명령문이 상형문자, 민중문자, 그리고 그리스어로 쓰여 있었기 때문에 학자들이 비교하면서 고대 이집트 문자의 의미를 해독할 수 있었거든요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 2
  StoryScript(
    id: "로제타스톤_5",
    storyId: dummyStoryRosetta.title,
    index: 5,
    role: "story_teller",
    text_en:
        "The stone recorded a decree issued by King Ptolemy V, which guaranteed the king’s cult.",
    text_ko:
        "이 돌에는 프톨레마이오스 5세가 내린 칙령이 기록되어 있어, 왕의 숭배를 보장했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_6",
    storyId: dummyStoryRosetta.title,
    index: 6,
    role: "story_teller",
    text_en:
        "Importantly, the Greek inscription was already understood, serving as a comparison tool for the other two scripts.",
    text_ko:
        "특히, 그리스어로 쓰인 부분은 이미 이해되고 있었기 때문에 나머지 두 문자 해독에 비교 자료로 쓰였죠.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_7",
    storyId: dummyStoryRosetta.title,
    index: 7,
    role: "story_teller",
    text_en:
        "Scholars quickly realized that comparing the texts could reveal the meanings of the mysterious symbols.",
    text_ko:
        "학자들은 곧 이 문장들을 비교하면 신비로운 상형문자의 의미를 밝혀낼 수 있다는 것을 깨달았어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_8",
    storyId: dummyStoryRosetta.title,
    index: 8,
    role: "me",
    text_en:
        "Haha, teacher, so that decree worked like a natural translator?",
    text_ko:
        "하하, 선생님, 그러니까 고대 왕의 명령서가 번역기처럼 작동한 건가요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_9",
    storyId: dummyStoryRosetta.title,
    index: 9,
    role: "story_teller",
    text_en:
        "Exactly! It acted like a natural translation tool, letting scholars decode hieroglyphics by comparing them with Greek.",
    text_ko:
        "정확해요! 그것은 자연스러운 번역 도구처럼 작용해서, 그리스어와 비교하여 상형문자를 해독할 수 있게 해줬죠.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 3
  StoryScript(
    id: "로제타스톤_10",
    storyId: dummyStoryRosetta.title,
    index: 10,
    role: "story_teller",
    text_en:
        "One brilliant scholar, Jean-François Champollion, made the breakthrough that finally cracked the code.",
    text_ko:
        "한 명의 뛰어난 학자, 장-프랑수아 샴폴리옹이 마침내 그 코드를 깨트리는 돌파구를 마련했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_11",
    storyId: dummyStoryRosetta.title,
    index: 11,
    role: "me",
    text_en: "Teacher, was Champollion really a genius?",
    text_ko: "선생님, 그 샴폴리옹 아저씨 정말 천재셨던 건가요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_12",
    storyId: dummyStoryRosetta.title,
    index: 12,
    role: "story_teller",
    text_en:
        "Absolutely, his deep understanding of languages and clever comparisons unlocked centuries of mystery.",
    text_ko:
        "물론이죠, 그의 언어에 대한 깊은 이해와 영리한 비교 덕분에 수 세기의 비밀이 풀렸어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 4
  StoryScript(
    id: "로제타스톤_13",
    storyId: dummyStoryRosetta.title,
    index: 13,
    role: "story_teller",
    text_en:
        "Champollion’s work opened a window to the ancient world, letting us read texts that had been silent for thousands of years.",
    text_ko:
        "샴폴리옹의 연구는 고대 세계로 가는 창문을 열어, 수천 년 동안 침묵해 있던 문서들을 읽을 수 있게 해줬어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_14",
    storyId: dummyStoryRosetta.title,
    index: 14,
    role: "story_teller",
    text_en:
        "His discovery not only deciphered the language but also revealed rich insights into ancient Egyptian culture.",
    text_ko:
        "그의 발견은 단순히 언어를 해독하는 것에 그치지 않고, 고대 이집트 문화에 대한 풍부한 통찰도 제공했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_15",
    storyId: dummyStoryRosetta.title,
    index: 15,
    role: "me",
    text_en:
        "Teacher, so thanks to that stone, we can reconnect with ancient Egypt, right?",
    text_ko:
        "선생님, 그러니까 그 돌 덕분에 우리가 고대 이집트를 다시 만날 수 있었던 거네요!",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_16",
    storyId: dummyStoryRosetta.title,
    index: 16,
    role: "story_teller",
    text_en:
        "Exactly. It was a turning point that transformed our understanding of history.",
    text_ko:
        "맞아요. 그것은 우리 역사 이해에 큰 변화를 가져온 전환점이었죠.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 5
  StoryScript(
    id: "로제타스톤_17",
    storyId: dummyStoryRosetta.title,
    index: 17,
    role: "story_teller",
    text_en:
        "After the breakthrough, scholars worldwide began to collaborate on translating more texts.",
    text_ko:
        "돌파구 이후, 전 세계의 학자들이 모여 더 많은 문서를 번역하는 협업을 시작했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_18",
    storyId: dummyStoryRosetta.title,
    index: 18,
    role: "story_teller",
    text_en:
        "They compared similar inscriptions and refined earlier translations with new insights.",
    text_ko:
        "그들은 비슷한 문구들을 비교하고 새로운 통찰력으로 이전 번역들을 수정했죠.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_19",
    storyId: dummyStoryRosetta.title,
    index: 19,
    role: "story_teller",
    text_en:
        "This teamwork paved the way for modern methods in deciphering ancient texts.",
    text_ko:
        "이런 협력은 고대 문자를 해독하는 현대적 방법론의 토대를 마련했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_20",
    storyId: dummyStoryRosetta.title,
    index: 20,
    role: "me",
    text_en: "Haha, teacher, it seems even ancient scholars worked great in teams!",
    text_ko: "하하, 선생님, 고대 학자들도 팀워크를 잘 발휘했군요!",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_21",
    storyId: dummyStoryRosetta.title,
    index: 21,
    role: "story_teller",
    text_en:
        "Right on. Their combined effort was key to cracking the long-held mystery of the stone.",
    text_ko:
        "맞아요. 그들의 공동 노력이 그 돌의 오랜 수수께끼를 풀어내는 열쇠였죠.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 6
  StoryScript(
    id: "로제타스톤_22",
    storyId: dummyStoryRosetta.title,
    index: 22,
    role: "story_teller",
    text_en:
        "The decipherment of the Rosetta Stone revolutionized the study of ancient Egypt.",
    text_ko:
        "로제타 스톤 해독은 고대 이집트 연구에 혁명을 가져왔어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_23",
    storyId: dummyStoryRosetta.title,
    index: 23,
    role: "story_teller",
    text_en:
        "It opened up a whole new world of knowledge about a long-forgotten civilization.",
    text_ko:
        "그것은 잊혀졌던 문명에 대한 새로운 지식의 세계를 열어주었죠.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_24",
    storyId: dummyStoryRosetta.title,
    index: 24,
    role: "me",
    text_en: "Teacher, that one stone really changed history!",
    text_ko: "선생님, 정말로 그 돌 하나가 역사를 바꿨던 거군요!",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_25",
    storyId: dummyStoryRosetta.title,
    index: 25,
    role: "story_teller",
    text_en:
        "Absolutely. It showed that even a single artifact can unlock the secrets of the past.",
    text_ko:
        "정말 그래요. 단 하나의 유물이 과거의 비밀을 풀 수 있다는 걸 증명해줬죠.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 7
  StoryScript(
    id: "로제타스톤_26",
    storyId: dummyStoryRosetta.title,
    index: 26,
    role: "story_teller",
    text_en:
        "This breakthrough not only advanced Egyptology but also changed the way history is studied.",
    text_ko:
        "이 돌파구는 이집트학 뿐 아니라 역사를 연구하는 방식도 크게 바꾸어 놓았어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_27",
    storyId: dummyStoryRosetta.title,
    index: 27,
    role: "me",
    text_en: "Teacher, so that event really revolutionized ancient history studies, huh?",
    text_ko: "선생님, 그럼 그 사건이 고대 역사 연구에 엄청난 변화를 준 거군요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_28",
    storyId: dummyStoryRosetta.title,
    index: 28,
    role: "story_teller",
    text_en:
        "Exactly. It set new standards for deciphering ancient scripts and boosted collaborative research.",
    text_ko:
        "맞아요. 고대 문자를 해독하는 새로운 기준을 세우고 협업 연구를 크게 진흥시켰죠.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 8
  StoryScript(
    id: "로제타스톤_29",
    storyId: dummyStoryRosetta.title,
    index: 29,
    role: "story_teller",
    text_en:
        "Today, the Rosetta Stone stands as a symbol of how curiosity and teamwork can break through even the toughest mysteries.",
    text_ko:
        "오늘날 로제타 스톤은 호기심과 팀워크가 가장 어려운 수수께끼도 풀 수 있음을 상징해요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_30",
    storyId: dummyStoryRosetta.title,
    index: 30,
    role: "me",
    text_en:
        "Teacher, I'll make sure to always stay curious and keep studying!",
    text_ko:
        "선생님, 저도 언제나 호기심을 잃지 않고 공부할게요!",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_31",
    storyId: dummyStoryRosetta.title,
    index: 31,
    role: "story_teller",
    text_en:
        "That's the spirit! The key to understanding history is asking questions and never giving up on learning.",
    text_ko:
        "바로 그 자세야! 역사를 이해하는 열쇠는 질문을 던지고 배움을 포기하지 않는 데 있단다.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "로제타스톤_32",
    storyId: dummyStoryRosetta.title,
    index: 32,
    role: "story_teller",
    text_en:
        "Remember, every discovery starts with a single question, and every question opens a door to the past.",
    text_ko:
        "기억해, 모든 발견은 한 가지 질문에서 시작되고, 그 질문이 과거로 가는 문을 열어준다는 걸.",
    updatedAt: Timestamp.now(),
  ),
];