import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/story_script.dart';

/// 📌 역사: 세계 최초의 신문은 어떤 모습이었을까?
final Story dummyStoryFirstNewspaper = Story(
  id: "first_newspaper",
  title: "세계 최초의 신문은 어떤 모습이었을까?",
  source: "Historical Documents",
  category: "history",
  readTime: "10-15 min",
  updatedAt: Timestamp.now(),
);

/// 아래 스크립트는 역사학자인 스토리 텔러(Teacher)와 역사를 배우는 학생(me) 사이의 대화입니다.
/// 대화는 9회차로 구성되어 있으며, 각 회차마다 스토리 텔러의 설명, 학생의 질문, 그리고 스토리 텔러의 답변이 자연스럽게 이어집니다.
/// 스토리 텔러의 설명은 회차마다 1~3문장으로 랜덤하게 구성되어 있습니다.
/// 전체 스크립트 개수는 35개입니다.
final List<StoryScript> dummyFirstNewspaperScripts = [
  // Cycle 1 (4 스크립트)
  StoryScript(
    id: "세계최초신문_1",
    storyId: dummyStoryFirstNewspaper.title,
    index: 1,
    role: "story_teller",
    text_en:
        "The world's first newspaper was very different from today's news. It was a simple, hand-written bulletin posted in public places.",
    text_ko:
        "세계 최초의 신문은 오늘날의 뉴스와 많이 달랐어요. 공공장소에 붙여진 간단한 손글씨 게시판이었죠.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_2",
    storyId: dummyStoryFirstNewspaper.title,
    index: 2,
    role: "story_teller",
    text_en:
        "It was used to share news and official announcements in ancient times.",
    text_ko:
        "옛날에는 소식과 공문서를 전하기 위해 사용되었어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_3",
    storyId: dummyStoryFirstNewspaper.title,
    index: 3,
    role: "me",
    text_en: "Teacher, was it like a giant poster on a wall?",
    text_ko: "선생님, 벽에 붙은 거대한 포스터 같은 거였나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_4",
    storyId: dummyStoryFirstNewspaper.title,
    index: 4,
    role: "story_teller",
    text_en:
        "Yes, in a way. It was very simple and clear, not fancy like our modern newspapers.",
    text_ko:
        "네, 그런 면이 있었어요. 현대 신문처럼 화려하지 않고 단순하며 명료했죠.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 2 (5 스크립트)
  StoryScript(
    id: "세계최초신문_5",
    storyId: dummyStoryFirstNewspaper.title,
    index: 5,
    role: "story_teller",
    text_en:
        "Some of the earliest news bulletins come from ancient Rome. They were called Acta Diurna.",
    text_ko:
        "초기의 뉴스 게시판 중 일부는 고대 로마에서 나왔어요. '악타 디우르나'라고 불렸죠.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_6",
    storyId: dummyStoryFirstNewspaper.title,
    index: 6,
    role: "story_teller",
    text_en:
        "They were carved in stone or written on papyrus and displayed for everyone to see.",
    text_ko:
        "그들은 돌에 새겨지거나 파피루스에 기록되어 모두가 볼 수 있도록 전시되었어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_7",
    storyId: dummyStoryFirstNewspaper.title,
    index: 7,
    role: "story_teller",
    text_en:
        "These bulletins were the main way people learned about events and government decisions.",
    text_ko:
        "이 게시판들은 사람들이 사건과 정부 결정을 알 수 있는 주요한 방법이었어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_8",
    storyId: dummyStoryFirstNewspaper.title,
    index: 8,
    role: "me",
    text_en: "Teacher, did people really read stone carvings for news?",
    text_ko: "선생님, 사람들이 정말 돌에 새긴 글을 뉴스로 읽었나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_9",
    storyId: dummyStoryFirstNewspaper.title,
    index: 9,
    role: "story_teller",
    text_en:
        "Yes, it was the best way to share important news back then, even if it seems odd now.",
    text_ko:
        "네, 그 당시에는 중요한 뉴스를 전하는 가장 좋은 방법이었어요. 지금은 이상하게 보일지 몰라도요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 3 (3 스크립트)
  StoryScript(
    id: "세계최초신문_10",
    storyId: dummyStoryFirstNewspaper.title,
    index: 10,
    role: "story_teller",
    text_en:
        "Later, the invention of the printing press made it possible to print newspapers.",
    text_ko:
        "후에 인쇄기의 발명이 신문 인쇄를 가능하게 만들었어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_11",
    storyId: dummyStoryFirstNewspaper.title,
    index: 11,
    role: "me",
    text_en: "Teacher, did the printing press really change everything?",
    text_ko: "선생님, 인쇄기가 정말 모든 것을 바꿨나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_12",
    storyId: dummyStoryFirstNewspaper.title,
    index: 12,
    role: "story_teller",
    text_en:
        "Exactly, it helped news reach many more people much faster.",
    text_ko:
        "맞아요, 덕분에 많은 사람들이 훨씬 빠르게 뉴스를 접할 수 있게 되었죠.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 4 (4 스크립트)
  StoryScript(
    id: "세계최초신문_13",
    storyId: dummyStoryFirstNewspaper.title,
    index: 13,
    role: "story_teller",
    text_en:
        "The printing press was a huge leap in communication. It allowed for faster news production.",
    text_ko:
        "인쇄기는 소통에 큰 도약이었어요. 신문을 빠르게 생산할 수 있게 해줬죠.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_14",
    storyId: dummyStoryFirstNewspaper.title,
    index: 14,
    role: "story_teller",
    text_en:
        "Newspapers became a way for people to share ideas and learn about the world.",
    text_ko:
        "신문은 사람들이 아이디어를 나누고 세상을 배울 수 있는 방법이 되었어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_15",
    storyId: dummyStoryFirstNewspaper.title,
    index: 15,
    role: "me",
    text_en: "Teacher, did people also gossip about the news on the streets?",
    text_ko: "선생님, 사람들은 거리에서도 뉴스에 대해 수다를 떨었나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_16",
    storyId: dummyStoryFirstNewspaper.title,
    index: 16,
    role: "story_teller",
    text_en:
        "Yes, they talked a lot about it and shared their opinions with friends and neighbors.",
    text_ko:
        "네, 많은 사람들이 그것에 대해 이야기하며 친구와 이웃과 의견을 나누었답니다.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 5 (5 스크립트)
  StoryScript(
    id: "세계최초신문_17",
    storyId: dummyStoryFirstNewspaper.title,
    index: 17,
    role: "story_teller",
    text_en:
        "In the 17th century, the first regular newspapers started in Europe. They were printed on paper.",
    text_ko:
        "17세기에 유럽에서 최초의 정기 신문들이 등장했어요. 종이에 인쇄되었죠.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_18",
    storyId: dummyStoryFirstNewspaper.title,
    index: 18,
    role: "story_teller",
    text_en:
        "These papers were delivered to towns and helped people know the latest events.",
    text_ko:
        "이 신문들은 도시로 배달되며 최신 사건을 알려줬어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_19",
    storyId: dummyStoryFirstNewspaper.title,
    index: 19,
    role: "story_teller",
    text_en:
        "This marked the start of modern journalism and public news.",
    text_ko:
        "이것은 현대 저널리즘과 공공 뉴스의 시작을 알렸어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_20",
    storyId: dummyStoryFirstNewspaper.title,
    index: 20,
    role: "me",
    text_en: "Teacher, were those early papers full of funny pictures?",
    text_ko: "선생님, 그 옛 신문들에 웃긴 그림들이 많았나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_21",
    storyId: dummyStoryFirstNewspaper.title,
    index: 21,
    role: "story_teller",
    text_en:
        "Not really; they mainly contained text and official news, but they paved the way for modern design.",
    text_ko:
        "아니요, 주로 글과 공식 뉴스만 있었지만, 현대 신문의 디자인에 큰 영향을 주었어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 6 (4 스크립트)
  StoryScript(
    id: "세계최초신문_22",
    storyId: dummyStoryFirstNewspaper.title,
    index: 22,
    role: "story_teller",
    text_en:
        "Over time, newspapers evolved to include local news and stories of daily life.",
    text_ko:
        "시간이 흐르면서 신문은 지역 뉴스와 일상 생활의 이야기를 담게 되었어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_23",
    storyId: dummyStoryFirstNewspaper.title,
    index: 23,
    role: "story_teller",
    text_en:
        "They became a major source for both facts and opinions among people.",
    text_ko:
        "사람들은 신문을 통해 사실과 의견을 모두 접하게 되었죠.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_24",
    storyId: dummyStoryFirstNewspaper.title,
    index: 24,
    role: "me",
    text_en: "Teacher, so were newspapers like the old social media?",
    text_ko: "선생님, 그러니까 신문은 옛날 소셜 미디어 같았던 건가요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_25",
    storyId: dummyStoryFirstNewspaper.title,
    index: 25,
    role: "story_teller",
    text_en:
        "In a way, yes. They connected communities and shared ideas like we do today online.",
    text_ko:
        "어느 정도는 맞아요. 신문은 오늘날 온라인처럼 공동체를 연결하고 아이디어를 나누었답니다.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 7 (3 스크립트)
  StoryScript(
    id: "세계최초신문_26",
    storyId: dummyStoryFirstNewspaper.title,
    index: 26,
    role: "story_teller",
    text_en:
        "The earliest newspapers were very simple and focused on key news.",
    text_ko:
        "최초의 신문은 매우 단순했으며, 중요한 뉴스만 담고 있었어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_27",
    storyId: dummyStoryFirstNewspaper.title,
    index: 27,
    role: "me",
    text_en: "Teacher, did people ever get bored reading the same news every day?",
    text_ko: "선생님, 사람들은 매일 같은 뉴스를 읽으며 지루해하지 않았나요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_28",
    storyId: dummyStoryFirstNewspaper.title,
    index: 28,
    role: "story_teller",
    text_en:
        "Many were surprised by it, but every day brought new events that kept them curious.",
    text_ko:
        "많은 사람들이 놀랐지만, 매일 새로운 사건이 있어서 호기심을 잃지 않았답니다.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 8 (4 스크립트)
  StoryScript(
    id: "세계최초신문_29",
    storyId: dummyStoryFirstNewspaper.title,
    index: 29,
    role: "story_teller",
    text_en:
        "Today, we study these early newspapers to learn about the roots of public news.",
    text_ko:
        "오늘날 우리는 이러한 초기 신문들을 연구하면서 공공 뉴스의 뿌리를 배우고 있어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_30",
    storyId: dummyStoryFirstNewspaper.title,
    index: 30,
    role: "story_teller",
    text_en:
        "They show us how simple tools and ideas grew into modern journalism.",
    text_ko:
        "그것들은 간단한 도구와 아이디어가 어떻게 현대 저널리즘으로 발전했는지를 보여줘요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_31",
    storyId: dummyStoryFirstNewspaper.title,
    index: 31,
    role: "me",
    text_en: "Teacher, so our daily news comes from those humble beginnings?",
    text_ko:
        "선생님, 그러니까 우리의 일간지는 그 소박한 시작에서 비롯된 건가요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_32",
    storyId: dummyStoryFirstNewspaper.title,
    index: 32,
    role: "story_teller",
    text_en:
        "Yes, they laid the foundation for the news media we use today.",
    text_ko:
        "네, 그것들이 오늘날 우리가 사용하는 뉴스 미디어의 기초를 닦았어요.",
    updatedAt: Timestamp.now(),
  ),

  // Cycle 9 (3 스크립트)
  StoryScript(
    id: "세계최초신문_33",
    storyId: dummyStoryFirstNewspaper.title,
    index: 33,
    role: "story_teller",
    text_en:
        "In summary, the world's first newspapers were humble but very important tools.",
    text_ko:
        "요약하자면, 최초의 신문은 소박했지만 매우 중요한 도구였어요.",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_34",
    storyId: dummyStoryFirstNewspaper.title,
    index: 34,
    role: "me",
    text_en: "Teacher, do you think ancient people ever got tired of reading news?",
    text_ko:
        "선생님, 고대 사람들은 뉴스를 읽는 것에 지루함을 느꼈을까요?",
    updatedAt: Timestamp.now(),
  ),
  StoryScript(
    id: "세계최초신문_35",
    storyId: dummyStoryFirstNewspaper.title,
    index: 35,
    role: "story_teller",
    text_en:
        "Maybe sometimes, but each day brought new stories that kept them interested.",
    text_ko:
        "가끔은 그랬겠지만, 매일 새로운 이야기가 있었기에 그들의 관심은 계속 유지되었답니다.",
    updatedAt: Timestamp.now(),
  ),
];