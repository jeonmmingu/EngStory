import 'package:eng_story/models/story.dart';
import 'package:eng_story/models/story_script.dart';
import 'package:eng_story/services/firebase_services.dart';

class StoryRepository {
  FirebaseCRUD firebaseCRUD = FirebaseCRUD();

  // Story
  // Create (storyId를 기준으로 생성)
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

  // Read (document 단위 1회 읽기)
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

  // Update (storyId를 기준으로 업데이트)
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

  // Delete (subcollection까지 삭제)
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

  // StoryScript
  // Create (storyId를 기준으로 생성)
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

  // Read (collection 전체 읽기)
  Future<List<StoryScript>> readStoryScripts(String storyId) async {
    try {
      return await firebaseCRUD.readCollectionData<StoryScript>(
        colRef: FirebaseRefs.colRefStory.doc(storyId).collection('scripts'),
        fromMap: (p0) => StoryScript.fromMap(p0),
      );
    } catch (err) {
      rethrow;
    }
  }

  // Update (id를 기준으로 업데이트)
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

  // Delete (script 단일 삭제)
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

  // Delete (script 전체 삭제)
  Future<void> deleteAllStoryScripts(String storyId) async {
    try {
      firebaseCRUD.deleteCollection(
          colRef: FirebaseRefs.colRefStory.doc(storyId).collection('scripts'));
    } catch (err) {
      rethrow;
    }
  }
}
