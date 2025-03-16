import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/story_script.dart';

/// 📌 역사: 이스터섬 모아이 석상의 숨겨진 비밀
final Story dummyStoryEasterMoai = Story(
  id: "easter_moai_secret",
  title: "이스터섬 모아이 석상의 숨겨진 비밀",
  source: "Historical Archives",
  category: "history",
  readTime: "10-15 min",
  updatedAt: Timestamp.now(),
);

/// 아래 스크립트는 역사학자인 스토리 텔러(Teacher)와 역사를 배우는 학생(me) 사이의 대화입니다.
/// 각 회차마다 스토리 텔러의 설명이 1~3문장 랜덤으로 나오고, 학생이 질문한 후 스토리 텔러가 답변하는 형식으로 구성됩니다.
/// 전체 스크립트 개수는 36개입니다.

final List<StoryScript> dummyEasterMoaiScripts = [
  // Cycle 1 (4 스크립트: 2 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "이스터섬모아이_1",
    storyId: dummyStoryEasterMoai.title,
    index: 1,
    role: "story_teller",
    text_en:
        "Easter Island is home to huge stone statues called Moai. They were built long ago by ancient people.",
    text_ko: "이스터섬에는 모아이라고 불리는 거대한 석상이 있어요. 이 석상들은 오래 전 고대 사람들이 만들었답니다.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_2",
    storyId: dummyStoryEasterMoai.title,
    index: 2,
    role: "story_teller",
    text_en:
        "These statues have large, deep eyes that seem to watch over the island.",
    text_ko: "이 석상들은 크고 깊은 눈을 가지고 있어, 섬 전체를 지켜보는 것처럼 보인답니다.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_3",
    storyId: dummyStoryEasterMoai.title,
    index: 3,
    role: "me",
    text_en: "Teacher, why did they make such huge statues?",
    text_ko: "선생님, 왜 그렇게 큰 석상을 만든 거예요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_4",
    storyId: dummyStoryEasterMoai.title,
    index: 4,
    role: "story_teller",
    text_en:
        "They built the Moai to honor their ancestors and show their strength.",
    text_ko: "그들은 조상들을 기리기 위해, 그리고 자신의 힘을 보여주기 위해 모아이를 만들었어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 2 (5 스크립트: 3 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "이스터섬모아이_5",
    storyId: dummyStoryEasterMoai.title,
    index: 5,
    role: "story_teller",
    text_en:
        "Many historians think the Moai hold a secret message about the island's past.",
    text_ko: "많은 역사학자들은 모아이에 섬의 옛 이야기가 숨겨져 있다고 생각해요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_6",
    storyId: dummyStoryEasterMoai.title,
    index: 6,
    role: "story_teller",
    text_en:
        "Some believe the statues hide clues about ancient rituals and life ways.",
    text_ko: "어떤 사람들은 이 석상들이 고대 의식과 생활 방식에 대한 단서를 숨기고 있다고 봐요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_7",
    storyId: dummyStoryEasterMoai.title,
    index: 7,
    role: "story_teller",
    text_en:
        "They may tell us how people lived many years ago on this remote island.",
    text_ko: "이 석상들은 먼 옛날, 이 외딴 섬에서 사람들이 어떻게 살았는지를 알려줄지도 몰라요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_8",
    storyId: dummyStoryEasterMoai.title,
    index: 8,
    role: "me",
    text_en:
        "Hehe, teacher, do you think the Moai ever get bored just standing there?",
    text_ko: "하하, 선생님, 모아이는 그냥 서 있기만 해서 지루해하지 않았을까요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_9",
    storyId: dummyStoryEasterMoai.title,
    index: 9,
    role: "story_teller",
    text_en:
        "Well, statues do not feel boredom, but they do remind us of a lost culture and its secrets.",
    text_ko: "음, 석상은 지루함을 느끼지 않지만, 우리에게 잃어버린 문화와 그 비밀을 상기시켜 주죠.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 3 (3 스크립트: 1 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "이스터섬모아이_10",
    storyId: dummyStoryEasterMoai.title,
    index: 10,
    role: "story_teller",
    text_en: "Explorers found the Moai on Easter Island many years ago.",
    text_ko: "탐험가들은 많은 해 전에 이스터섬에서 모아이를 발견했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_11",
    storyId: dummyStoryEasterMoai.title,
    index: 11,
    role: "me",
    text_en: "Teacher, were there any treasure maps hidden on them?",
    text_ko: "선생님, 그 석상에 보물 지도가 숨겨져 있었나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_12",
    storyId: dummyStoryEasterMoai.title,
    index: 12,
    role: "story_teller",
    text_en:
        "No, not treasure maps, but they do give us clues to the past that help us learn history.",
    text_ko: "아니요, 보물 지도는 아니었지만, 그 석상들은 과거에 대한 단서를 제공해 역사 공부에 도움을 주었어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 4 (4 스크립트: 2 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "이스터섬모아이_13",
    storyId: dummyStoryEasterMoai.title,
    index: 13,
    role: "story_teller",
    text_en:
        "One mystery is how these very heavy statues were moved from the quarry to their sites.",
    text_ko: "한 가지 수수께끼는 이처럼 무거운 석상들이 채석장에서 제자리에 어떻게 옮겨졌는지에 대한 거예요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_14",
    storyId: dummyStoryEasterMoai.title,
    index: 14,
    role: "story_teller",
    text_en:
        "Some think teams of people used ropes and logs to roll them along the ground.",
    text_ko: "어떤 이들은 사람들이 밧줄과 통나무를 사용해 땅 위에서 굴렸다고 추측해요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_15",
    storyId: dummyStoryEasterMoai.title,
    index: 15,
    role: "me",
    text_en: "Teacher, did they use giant wheels or something silly like that?",
    text_ko: "선생님, 거대한 바퀴를 썼던 건가요? 장난처럼요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_16",
    storyId: dummyStoryEasterMoai.title,
    index: 16,
    role: "story_teller",
    text_en:
        "No, they used simple tools like ropes and logs, and many strong people to move them by hand.",
    text_ko: "아니요, 밧줄과 통나무 같은 간단한 도구와 많은 사람들이 힘을 합쳐 옮겼답니다.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 5 (5 스크립트: 3 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "이스터섬모아이_17",
    storyId: dummyStoryEasterMoai.title,
    index: 17,
    role: "story_teller",
    text_en:
        "Some studies show that the Moai are aligned with the stars. This means the builders may have used the sky to guide them.",
    text_ko:
        "어떤 연구에 따르면, 모아이는 별들과 일직선상에 놓여 있어요. 이는 건축가들이 하늘의 위치를 이용했을 수도 있음을 뜻해요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_18",
    storyId: dummyStoryEasterMoai.title,
    index: 18,
    role: "story_teller",
    text_en:
        "The alignment may also show a deep connection between the people and the cosmos.",
    text_ko: "이 정렬은 사람들과 우주 사이의 깊은 연결고리를 보여주기도 해요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_19",
    storyId: dummyStoryEasterMoai.title,
    index: 19,
    role: "story_teller",
    text_en: "It is like they looked to the stars for guidance in life.",
    text_ko: "마치 인생의 길을 찾기 위해 별을 바라본 것과 같아요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_20",
    storyId: dummyStoryEasterMoai.title,
    index: 20,
    role: "me",
    text_en: "Teacher, so are the Moai like ancient space guides?",
    text_ko: "선생님, 그러니까 모아이는 고대의 우주 길잡이 같은 건가요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_21",
    storyId: dummyStoryEasterMoai.title,
    index: 21,
    role: "story_teller",
    text_en:
        "In a way, yes. They show how people used nature to find their way and understand the world.",
    text_ko: "어느 면에서는 그렇죠. 모아이는 사람들이 자연을 통해 길을 찾고 세상을 이해했다는 것을 보여줘요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 6 (4 스크립트: 2 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "이스터섬모아이_22",
    storyId: dummyStoryEasterMoai.title,
    index: 22,
    role: "story_teller",
    text_en:
        "There are carvings on some Moai that many believe hide secret messages.",
    text_ko: "일부 모아이에는 많은 이들이 비밀 메시지가 숨겨져 있다고 믿는 조각들이 있어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_23",
    storyId: dummyStoryEasterMoai.title,
    index: 23,
    role: "story_teller",
    text_en:
        "These messages might tell us about rituals and the old way of life on the island.",
    text_ko: "이 메시지들은 섬의 옛 생활 방식과 의식에 대해 알려줄지도 몰라요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_24",
    storyId: dummyStoryEasterMoai.title,
    index: 24,
    role: "me",
    text_en:
        "Teacher, do you think they left secret recipes or something funny like that?",
    text_ko: "선생님, 혹시 비밀 레시피 같은 장난스러운 것도 남겼을까요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_25",
    storyId: dummyStoryEasterMoai.title,
    index: 25,
    role: "story_teller",
    text_en:
        "Not recipes, but they did leave messages about their beliefs and life.",
    text_ko: "레시피는 아니지만, 그들의 신념과 생활에 대한 메시지는 남겼답니다.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 7 (3 스크립트: 1 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "이스터섬모아이_26",
    storyId: dummyStoryEasterMoai.title,
    index: 26,
    role: "story_teller",
    text_en:
        "Today, the Moai inspire art, films, and books all over the world.",
    text_ko: "오늘날 모아이는 전 세계의 예술, 영화, 책에 영감을 주고 있어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_27",
    storyId: dummyStoryEasterMoai.title,
    index: 27,
    role: "me",
    text_en: "Teacher, do you think the Moai would take selfies if they could?",
    text_ko: "선생님, 만약 모아이가 셀카를 찍을 수 있다면 어땠을까요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_28",
    storyId: dummyStoryEasterMoai.title,
    index: 28,
    role: "story_teller",
    text_en:
        "Haha, maybe! But really, they remind us to respect and learn from our past.",
    text_ko:
        "하하, 아마도 그럴 수도 있겠죠! 하지만 진짜로, 모아이는 우리에게 과거를 존중하고 배워야 한다는 것을 상기시켜줘요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 8 (4 스크립트: 2 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "이스터섬모아이_29",
    storyId: dummyStoryEasterMoai.title,
    index: 29,
    role: "story_teller",
    text_en:
        "Historians work hard to protect the Moai and preserve the secrets of Easter Island.",
    text_ko: "역사학자들은 모아이를 보호하고 이스터섬의 비밀을 보존하기 위해 열심히 일하고 있어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_30",
    storyId: dummyStoryEasterMoai.title,
    index: 30,
    role: "story_teller",
    text_en:
        "They believe that every stone has a story that connects us to ancient times.",
    text_ko: "그들은 모든 석상이 고대와 우리를 연결하는 이야기를 담고 있다고 믿어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_31",
    storyId: dummyStoryEasterMoai.title,
    index: 31,
    role: "me",
    text_en: "Teacher, how can we help keep these secrets safe for the future?",
    text_ko: "선생님, 미래를 위해 이 비밀들을 어떻게 지켜나갈 수 있을까요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_32",
    storyId: dummyStoryEasterMoai.title,
    index: 32,
    role: "story_teller",
    text_en:
        "By studying and respecting our history, we can learn to preserve these treasures.",
    text_ko: "역사를 공부하고 존중함으로써, 우리는 이 보물들을 지킬 수 있어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 9 (4 스크립트: 2 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "이스터섬모아이_33",
    storyId: dummyStoryEasterMoai.title,
    index: 33,
    role: "story_teller",
    text_en:
        "In the end, the Moai hold many secrets that still puzzle us today.",
    text_ko: "결국, 모아이는 오늘날에도 우리를 혼란스럽게 하는 많은 비밀을 품고 있어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_34",
    storyId: dummyStoryEasterMoai.title,
    index: 34,
    role: "story_teller",
    text_en:
        "They teach us that even silent stones can speak volumes about our past.",
    text_ko: "이 석상들은 침묵 속에서도 과거에 대해 많은 것을 이야기해준다는 것을 가르쳐줘요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_35",
    storyId: dummyStoryEasterMoai.title,
    index: 35,
    role: "me",
    text_en: "Teacher, do you think you'll ever learn all their secrets?",
    text_ko: "선생님, 혹시 그들의 모든 비밀을 다 알게 될까요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "이스터섬모아이_36",
    storyId: dummyStoryEasterMoai.title,
    index: 36,
    role: "story_teller",
    text_en:
        "Maybe not all, but every question we ask brings us a little closer to understanding our past.",
    text_ko: "모든 비밀을 다 알 수는 없겠지만, 우리가 던지는 모든 질문이 과거를 조금씩 이해하게 해준답니다.",
    updatedAt: Timestamp.now(),
  ),
];
