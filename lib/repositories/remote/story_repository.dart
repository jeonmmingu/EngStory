import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/story_script.dart';
import 'package:eng_story/services/remote/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoryRepository {
  FirebaseCRUD firebaseCRUD = FirebaseCRUD();

  // ------------------- 📌 Story 관련 CRUD -------------------

  /// 🔹 스토리 생성 (Create)
  Future<void> createStory(String storyId, Story story) async {
    try {
      await firebaseCRUD.createDocument<Story>(
        docRef: FirebaseRefs.colRefStory.doc(storyId),
        data: story,
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 스토리 조회 (Read, 단일 문서)
  Future<Story?> readStory(String storyId) async {
    try {
      return await firebaseCRUD.readDocument<Story>(
        docRef: FirebaseRefs.colRefStory.doc(storyId),
        fromMap: (p0) => Story.fromMap(p0),
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 모든 스토리 조회 (Read All)
  Future<List<Story>> readAllStories() async {
    try {
      final querySnapshot = await FirebaseRefs.colRefStory.get();

      return querySnapshot.docs
          .map((doc) {
            try {
              return Story.fromMap(doc.data() as Map<String, dynamic>);
            } catch (e) {
              debugPrint("⚠ Firestore 데이터 변환 실패: $e");
              return null;
            }
          })
          .whereType<Story>()
          .toList();
    } catch (err) {
      debugPrint("❌ 모든 스토리 조회 실패: $err");
      return [];
    }
  }

  /// 🔹 필터링된 스토리 조회 (조건 옵션 추가)
  Future<List<Story>> readFilteredStories({
    required String field,
    required dynamic value,
    String condition = "isEqualTo",
  }) async {
    try {
      Query query = FirebaseRefs.colRefStory;

      if (condition == "isEqualTo") {
        query = query.where(field, isEqualTo: value);
      } else if (condition == "isGreaterThan") {
        query = query.where(field, isGreaterThan: value);

      } else {
        throw Exception("❌ 지원하지 않는 조건: $condition");
      }

      final querySnapshot = await query.get();

      return querySnapshot.docs
          .map((doc) {
            try {
              return Story.fromMap(doc.data() as Map<String, dynamic>);
            } catch (e) {
              debugPrint("⚠ Firestore 데이터 변환 실패: $e");
              return null;
            }
          })
          .whereType<Story>()
          .toList();
    } catch (err) {
      debugPrint("❌ 필터링된 스토리 조회 실패: $err");
      return [];
    }
  }

  /// 🔹 스토리 업데이트 (Update)
  Future<void> updateStory(String storyId, Map<String, dynamic> data) async {
    try {
      await firebaseCRUD.updateDocument(
        docRef: FirebaseRefs.colRefStory.doc(storyId),
        data: data,
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 스토리 삭제 (Delete, scripts 서브컬렉션 포함)
  Future<void> deleteStory(String storyId) async {
    try {
      await firebaseCRUD.deleteCollection(
          colRef: FirebaseRefs.colRefStory.doc(storyId).collection('scripts'));
      await firebaseCRUD.deleteDocument(
          docRef: FirebaseRefs.colRefStory.doc(storyId));
    } catch (err) {
      rethrow;
    }
  }

  // ------------------- 📌 StoryScript 관련 CRUD -------------------

  /// 🔹 스토리 스크립트 생성 (Create)
  Future<void> createStoryScript(
      String storyId, String scriptId, StoryScript storyScript) async {
    try {
      await firebaseCRUD.createDocument<StoryScript>(
        docRef: FirebaseRefs.colRefStory
            .doc(storyId)
            .collection('scripts')
            .doc(scriptId),
        data: storyScript,
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 스토리 스크립트 조회 (Read, 단일)
  Future<StoryScript?> readStoryScript(String storyId, String scriptId) async {
    try {
      return await firebaseCRUD.readDocument<StoryScript>(
        docRef: FirebaseRefs.colRefStory
            .doc(storyId)
            .collection('scripts')
            .doc(scriptId),
        fromMap: (p0) => StoryScript.fromMap(p0),
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 스토리의 모든 스크립트 조회 (Read All)
  Future<List<StoryScript>> readAllStoryScripts(String storyId) async {
    try {
      return await firebaseCRUD.readCollectionData<StoryScript>(
        colRef: FirebaseRefs.colRefStory.doc(storyId).collection('scripts'),
        fromMap: (p0) => StoryScript.fromMap(p0),
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 스토리 스크립트 업데이트 (Update)
  Future<void> updateStoryScript(
      String storyId, String scriptId, Map<String, dynamic> data) async {
    try {
      await firebaseCRUD.updateDocument(
        docRef: FirebaseRefs.colRefStory
            .doc(storyId)
            .collection('scripts')
            .doc(scriptId),
        data: data,
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 스토리 스크립트 삭제 (Delete, 단일)
  Future<void> deleteStoryScript(String storyId, String scriptId) async {
    try {
      await firebaseCRUD.deleteDocument(
        docRef: FirebaseRefs.colRefStory
            .doc(storyId)
            .collection('scripts')
            .doc(scriptId),
      );
    } catch (err) {
      rethrow;
    }
  }

  /// 🔹 스토리의 모든 스크립트 삭제 (Delete All)
  Future<void> deleteAllStoryScripts(String storyId) async {
    try {
      await firebaseCRUD.deleteCollection(
          colRef: FirebaseRefs.colRefStory.doc(storyId).collection('scripts'));
    } catch (err) {
      rethrow;
    }
  }
}