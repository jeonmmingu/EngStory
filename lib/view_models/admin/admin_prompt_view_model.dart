import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_story/core/enums/story_category.dart';
import 'package:eng_story/core/enums/story_time.dart';
import 'package:eng_story/core/enums/story_tone.dart';
import 'package:eng_story/models/prompt.dart';
import 'package:eng_story/repositories/remote/prompt_repository.dart';
import 'package:flutter/material.dart';

class AdminPromptViewModel extends ChangeNotifier {
  // MARK: - Prompt 생성
  // prompt repository
  final PromptRepostiory _promptRepository = PromptRepostiory();

  // title TextEditingController
  final TextEditingController titleController = TextEditingController();

  // content TextEditingController
  final TextEditingController contentController = TextEditingController();

  // mood TextEditingController
  final TextEditingController moodController = TextEditingController();

  // category Enum
  StoryCategory? _category;
  StoryCategory? get category => _category;

  // readTime Enum
  StoryTime? _readTime;
  StoryTime? get readTime => _readTime;

  // tone Enum
  StoryTone? _tone;
  StoryTone? get tone => _tone;

  // TextEditingController 변경 시, notifyListeners
  void textEditingControllerChanged() {
    notifyListeners();
  }

  // set category
  void setCategory(StoryCategory? category) {
    _category = category;
    notifyListeners();
  }

  // set readTime
  void setReadTime(StoryTime? readTime) {
    _readTime = readTime;
    notifyListeners();
  }

  // set tone
  void setTone(StoryTone? tone) {
    _tone = tone;
    notifyListeners();
  }

  // save prompt
  Future<void> savePrompt() async {
    // prompt 생성
    String prompt = Prompt.makePromptText(
      titleController.text,
      contentController.text,
      moodController.text,
      _category!.name,
      _readTime!.name,
      _tone!.name,
    );
    // prompt 저장
    Timestamp now = Timestamp.now();
    try {
      await _promptRepository.createPrompt(
        now.toString(),
        Prompt(
          title: titleController.text,
          content: contentController.text,
          mood: moodController.text,
          category: _category!.name,
          readTime: _readTime!.name,
          tone: _tone!.name,
          createdAt: now,
          promptText: prompt,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  bool get checkSaveValidation =>
      titleController.text.isNotEmpty &&
      contentController.text.isNotEmpty &&
      moodController.text.isNotEmpty &&
      _category != null &&
      _readTime != null &&
      _tone != null;

  void resetAllStates() {
    titleController.clear();
    contentController.clear();
    moodController.clear();
    _category = null;
    _readTime = null;
    _tone = null;
    notifyListeners();
  }

  // MARK: - Prompt 관리
  // 생성된 Prompt 목록
  List<Prompt> _promptList = [];
  List<Prompt> get promptList => _promptList;

  // selected prompt
  Prompt? _selectedPrompt;
  Prompt? get selectedPrompt => _selectedPrompt;

  // Prompt 목록 가져오기
  Future<void> getPromptList() async {
    // Prompt 목록 가져오기
    try {
      _promptList = await _promptRepository.readPromptList();
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  // Prompt 삭제
  Future<void> deletePrompt(String promptId) async {
    try {
      // Prompt 삭제
      await _promptRepository.deletePrompt(promptId);
      // Prompt 목록 갱신
      await getPromptList();
    } catch (err) {
      rethrow;
    }
  }

  // Prompt 선택
  void selectPrompt(Prompt prompt) {
    _selectedPrompt = prompt;
    notifyListeners();
  }
}
