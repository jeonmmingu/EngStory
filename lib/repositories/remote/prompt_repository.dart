import 'package:eng_story/models/prompt.dart';
import 'package:eng_story/services/remote/firebase_services.dart';

class PromptRepostiory {
  FirebaseCRUD firebaseCRUD = FirebaseCRUD();

  // ------------------- 📌 Prompt 관련 CRUD -------------------

  /// 🔹 Prompt 생성 (Create)
  Future<void> createPrompt(String promptId, Prompt prompt) async {
    try {
      await firebaseCRUD.createDocument<Prompt>(
        docRef: FirebaseRefs.colRefPrompt.doc(promptId),
        data: prompt,
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 Prompt 조회 (Read)
  Future<Prompt?> readPrompt(String promptId) async {
    try {
      return await firebaseCRUD.readDocument<Prompt>(
        docRef: FirebaseRefs.colRefPrompt.doc(promptId),
        fromMap: (json) => Prompt.fromJson(json),
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 Prompt 목록 조회 (Read)
  Future<List<Prompt>> readPromptList() async {
    try {
      return await firebaseCRUD.readCollectionData<Prompt>(
        colRef: FirebaseRefs.colRefPrompt,
        fromMap: (json) => Prompt.fromJson(json),
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 Prompt 업데이트 (Update)
  Future<void> updatePrompt(String promptId, Map<String, dynamic> data) async {
    try {
      await firebaseCRUD.updateDocument(
        docRef: FirebaseRefs.colRefPrompt.doc(promptId),
        data: data,
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 Prompt 삭제 (Delete)
  Future<void> deletePrompt(String promptId) async {
    try {
      await FirebaseRefs.colRefPrompt.doc(promptId).delete();
    } catch (err) {
      rethrow;
    }
  }
}
