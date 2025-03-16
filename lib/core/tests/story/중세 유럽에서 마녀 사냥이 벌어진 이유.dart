import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/story_script.dart';

/// 📌 역사: 중세 유럽에서 마녀 사냥이 벌어진 이유
final Story dummyStoryWitchHunt = Story(
  id: "witch_hunt_reason",
  title: "중세 유럽에서 마녀 사냥이 벌어진 이유",
  source: "Historical Archives",
  category: "history",
  readTime: "15-20 min",
  updatedAt: Timestamp.now(),
);

/// 아래 스크립트는 역사학자인 스토리 텔러(Teacher)와 역사를 배우는 학생(me) 사이의 대화입니다.
/// 각 회차마다 스토리 텔러의 설명(1~3문장 랜덤) → 학생의 질문 → 스토리 텔러의 답변이 자연스럽게 이어집니다.
/// 전체 스크립트는 9회차로 구성되어 총 36개의 스크립트로 제작되었습니다.

final List<StoryScript> dummyWitchHuntScripts = [
  // Cycle 1 (4 스크립트: 2 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "중세마녀_1",
    storyId: dummyStoryWitchHunt.title,
    index: 1,
    role: "story_teller",
    text_en:
        "In medieval Europe, fear and superstition spread far and wide.",
    text_ko:
        "중세 유럽에서는 두려움과 미신이 널리 퍼졌어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_2",
    storyId: dummyStoryWitchHunt.title,
    index: 2,
    role: "story_teller",
    text_en:
        "Many people believed that witches made pacts with the devil and could cast harmful spells.",
    text_ko:
        "많은 사람들은 마녀들이 악마와 계약을 맺어 해로운 주문을 쓸 수 있다고 믿었어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_3",
    storyId: dummyStoryWitchHunt.title,
    index: 3,
    role: "me",
    text_en: "Teacher, so did they really think witches were like real monsters?",
    text_ko: "선생님, 사람들은 정말 마녀가 진짜 괴물이라고 생각했나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_4",
    storyId: dummyStoryWitchHunt.title,
    index: 4,
    role: "story_teller",
    text_en:
        "Yes, many believed witches had evil powers and were dangerous, which led to widespread fear.",
    text_ko:
        "네, 많은 이들이 마녀들이 악한 힘을 가지고 위험하다고 믿어 두려움이 퍼졌어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 2 (5 스크립트: 3 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "중세마녀_5",
    storyId: dummyStoryWitchHunt.title,
    index: 5,
    role: "story_teller",
    text_en:
        "The church played a big role in starting the witch hunts.",
    text_ko:
        "교회는 마녀 사냥을 시작하는 데 큰 역할을 했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_6",
    storyId: dummyStoryWitchHunt.title,
    index: 6,
    role: "story_teller",
    text_en:
        "Religious leaders warned that witchcraft was a sin that angered God.",
    text_ko:
        "종교 지도자들은 마법 행위가 신을 화나게 하는 죄라고 경고했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_7",
    storyId: dummyStoryWitchHunt.title,
    index: 7,
    role: "story_teller",
    text_en:
        "They held harsh trials and used brutal punishments to stop what they saw as evil.",
    text_ko:
        "그들은 잔혹한 재판과 처벌을 통해 악을 막으려 했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_8",
    storyId: dummyStoryWitchHunt.title,
    index: 8,
    role: "me",
    text_en: "Teacher, so did they think witches could fly on brooms?",
    text_ko: "선생님, 마녀들이 빗자루를 타고 날 수 있다고 믿었나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_9",
    storyId: dummyStoryWitchHunt.title,
    index: 9,
    role: "story_teller",
    text_en:
        "Sometimes they believed in magic, but it was more about using fear to control people.",
    text_ko:
        "때때로 마법을 믿기도 했지만, 결국 사람들을 통제하기 위한 두려움이 더 컸어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 3 (3 스크립트: 1 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "중세마녀_10",
    storyId: dummyStoryWitchHunt.title,
    index: 10,
    role: "story_teller",
    text_en:
        "Economic and social troubles also fueled the witch hunts.",
    text_ko:
        "경제적, 사회적 어려움 또한 마녀 사냥의 원인이 되었어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_11",
    storyId: dummyStoryWitchHunt.title,
    index: 11,
    role: "me",
    text_en: "Teacher, so bad times made people blame witches?",
    text_ko: "선생님, 어려운 시절에 사람들이 마녀를 탓한 건가요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_12",
    storyId: dummyStoryWitchHunt.title,
    index: 12,
    role: "story_teller",
    text_en:
        "Yes, they blamed witches for bad harvests and misfortunes to explain their hardships.",
    text_ko:
        "네, 어려움을 설명하기 위해 마녀를 탓하며 가뭄이나 불행을 겪었다고 믿었어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 4 (4 스크립트: 2 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "중세마녀_13",
    storyId: dummyStoryWitchHunt.title,
    index: 13,
    role: "story_teller",
    text_en:
        "Local leaders sometimes used witch hunts to settle personal scores and control people.",
    text_ko:
        "지역 지도자들은 때때로 개인의 원한을 풀거나 사람들을 통제하기 위해 마녀 사냥을 이용했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_14",
    storyId: dummyStoryWitchHunt.title,
    index: 14,
    role: "story_teller",
    text_en:
        "Accusations were often based on rumors and personal grudges rather than facts.",
    text_ko:
        "혐의는 사실보다는 소문과 개인적인 원한에 근거한 경우가 많았어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_15",
    storyId: dummyStoryWitchHunt.title,
    index: 15,
    role: "me",
    text_en: "Teacher, did people really get confused about who was a witch?",
    text_ko: "선생님, 사람들이 누가 마녀인지 헷갈렸던 적도 있었나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_16",
    storyId: dummyStoryWitchHunt.title,
    index: 16,
    role: "story_teller",
    text_en:
        "Indeed, many innocent people were wrongly accused due to fear and gossip.",
    text_ko:
        "맞아요, 두려움과 소문 때문에 많은 무고한 사람들이 잘못 고발되었어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 5 (4 스크립트: 2 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "중세마녀_17",
    storyId: dummyStoryWitchHunt.title,
    index: 17,
    role: "story_teller",
    text_en:
        "Witch trials were very harsh. Torture was often used to force people to confess.",
    text_ko:
        "마녀 재판은 매우 잔인했어요. 고문을 사용해 자백을 끌어내기도 했죠.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_18",
    storyId: dummyStoryWitchHunt.title,
    index: 18,
    role: "story_teller",
    text_en:
        "Historical records show that thousands suffered during these dark times.",
    text_ko:
        "역사 기록에 따르면, 수천 명이 이 암울한 시기에 고통받았어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_19",
    storyId: dummyStoryWitchHunt.title,
    index: 19,
    role: "me",
    text_en: "Teacher, that's awful! Did the witch hunts ever stop?",
    text_ko: "선생님, 정말 끔찍하네요! 마녀 사냥은 결국 멈췄나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_20",
    storyId: dummyStoryWitchHunt.title,
    index: 20,
    role: "story_teller",
    text_en:
        "Over time, new ideas and reforms helped end the witch hunts, though the scars remain.",
    text_ko:
        "시간이 지나면서 새로운 사상과 개혁으로 마녀 사냥은 점차 종식되었지만, 그 상처는 남아 있어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 6 (5 스크립트: 3 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "중세마녀_21",
    storyId: dummyStoryWitchHunt.title,
    index: 21,
    role: "story_teller",
    text_en:
        "Historians have found trial records and documents that detail these events.",
    text_ko:
        "역사학자들은 이 사건들을 자세히 기록한 재판 기록과 문서를 발견했어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_22",
    storyId: dummyStoryWitchHunt.title,
    index: 22,
    role: "story_teller",
    text_en:
        "These documents reveal that fear, religion, and politics were all linked in the witch hunts.",
    text_ko:
        "이 문서들은 마녀 사냥에서 두려움, 종교, 정치가 모두 연결되어 있었다는 것을 보여줘요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_23",
    storyId: dummyStoryWitchHunt.title,
    index: 23,
    role: "story_teller",
    text_en:
        "They help us understand the mindset of people living in those troubled times.",
    text_ko:
        "그것들은 그 어려운 시절에 살던 사람들의 사고방식을 이해하는 데 도움을 줘요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_24",
    storyId: dummyStoryWitchHunt.title,
    index: 24,
    role: "me",
    text_en: "Teacher, so they actually wrote all this down on paper?",
    text_ko: "선생님, 그 모든 내용을 실제로 종이에 기록했나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_25",
    storyId: dummyStoryWitchHunt.title,
    index: 25,
    role: "story_teller",
    text_en:
        "Yes, many trial records still exist today, showing the harsh truth of those times.",
    text_ko:
        "네, 오늘날에도 많은 재판 기록이 남아 있어 그 시절의 잔혹함을 증명해주고 있어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 7 (4 스크립트: 2 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "중세마녀_26",
    storyId: dummyStoryWitchHunt.title,
    index: 26,
    role: "story_teller",
    text_en:
        "The witch hunts had a deep impact on society, leaving scars that last for centuries.",
    text_ko:
        "마녀 사냥은 사회에 깊은 영향을 끼쳐, 수세기 동안 상처로 남았어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_27",
    storyId: dummyStoryWitchHunt.title,
    index: 27,
    role: "story_teller",
    text_en:
        "They remind us how mass hysteria and injustice can lead to tragic events.",
    text_ko:
        "그것들은 집단 히스테리와 부당함이 어떻게 비극적인 사건으로 이어질 수 있는지를 상기시켜 줘요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_28",
    storyId: dummyStoryWitchHunt.title,
    index: 28,
    role: "me",
    text_en: "Teacher, so it was like a big, scary group project that went horribly wrong?",
    text_ko: "선생님, 그러니까 그건 엄청난 공포의 집단 프로젝트가 엉망으로 끝난 것과 같았던 건가요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_29",
    storyId: dummyStoryWitchHunt.title,
    index: 29,
    role: "story_teller",
    text_en:
        "In a funny way, yes; it was a failure of reason where fear ruled over facts.",
    text_ko:
        "재미있게도 그렇죠; 이성보다 두려움이 앞선 실패였다고 할 수 있어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 8 (3 스크립트: 1 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "중세마녀_30",
    storyId: dummyStoryWitchHunt.title,
    index: 30,
    role: "story_teller",
    text_en:
        "Modern historians study these events to learn lessons about tolerance and reason.",
    text_ko:
        "현대 역사학자들은 이 사건들을 통해 관용과 이성에 관한 교훈을 얻으려 해요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_31",
    storyId: dummyStoryWitchHunt.title,
    index: 31,
    role: "me",
    text_en: "Teacher, do you think we still see a bit of that fear today?",
    text_ko: "선생님, 요즘에도 그 두려움의 흔적을 볼 수 있다고 생각하세요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_32",
    storyId: dummyStoryWitchHunt.title,
    index: 32,
    role: "story_teller",
    text_en:
        "Some ideas linger, but now we value evidence and fairness much more.",
    text_ko:
        "어떤 생각은 남아있지만, 지금은 증거와 공정함을 훨씬 더 소중하게 여겨요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 9 (4 스크립트: 2 설명 + 1 질문 + 1 답변)
  StoryScript(
    id: "중세마녀_33",
    storyId: dummyStoryWitchHunt.title,
    index: 33,
    role: "story_teller",
    text_en:
        "Witch hunts show us a time when fear ruled over reason and innocent lives were lost.",
    text_ko:
        "마녀 사냥은 두려움이 이성을 지배했던 시절, 무고한 사람들이 희생되었던 때를 보여줘요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_34",
    storyId: dummyStoryWitchHunt.title,
    index: 34,
    role: "story_teller",
    text_en:
        "They teach us the danger of letting mass hysteria and rumors control society.",
    text_ko:
        "그것은 집단 히스테리와 소문이 사회를 지배하는 위험을 가르쳐 주죠.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_35",
    storyId: dummyStoryWitchHunt.title,
    index: 35,
    role: "me",
    text_en: "Teacher, so history warns us not to let fear control our minds?",
    text_ko:
        "선생님, 그러니까 역사는 두려움이 우리의 생각을 지배하지 않도록 경고하는 건가요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "중세마녀_36",
    storyId: dummyStoryWitchHunt.title,
    index: 36,
    role: "story_teller",
    text_en:
        "Exactly, and that is why we study history—to learn from the past and make a better future.",
    text_ko:
        "맞아요, 그래서 역사를 공부하는 거예요—과거에서 배우고 더 나은 미래를 만들기 위해서요.",
    updatedAt: Timestamp.now(),
  ),
];