import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eng_story/models/json_serializable.dart';

class FirebaseInstance {
  static FirebaseFirestore db = FirebaseFirestore.instance;
}

class FirebaseRefs {
  static CollectionReference colRefUser =
      FirebaseInstance.db.collection("users");
}

class FirebaseCRUD {
  // Document CRUD
  // Create
  Future<bool> createDocument<T extends JsonSerializable>({
    required DocumentReference docRef,
    required T data,
  }) async {
    try {
      await docRef.set(data.toJson());
      return true;
    } catch (err) {
      rethrow;
    }
  }

  // Read (Document 데이터를 불러오도록 함)
  Future<T?> readDocument<T extends JsonSerializable>({
    required DocumentReference docRef,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        return fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (err) {
      rethrow;
    }
  }

  // Read (Document Stream 데이터를 불러오도록 함)
  Stream<DocumentSnapshot<Object?>> readDocumentSnapshot({
    required DocumentReference docRef,
  }) {
    try {
      return docRef.snapshots();
    } catch (err) {
      rethrow;
    }
  }

  // Read (Collection Stream 데이터를 불러오도록 함)
  Stream<QuerySnapshot> readCollection({
    required CollectionReference colRef,
  }) {
    return colRef.snapshots();
  }

  // Update
  Future<void> updateDocument({
    required DocumentReference docRef,
    required Map<String, dynamic> data,
  }) async {
    try {
      await docRef.update(data);
    } catch (err) {
      rethrow;
    }
  }

  // Delete
  Future<bool> deleteDocument({
    required DocumentReference docRef,
  }) async {
    try {
      await docRef.delete();
      return true;
    } catch (err) {
      rethrow;
    }
  }

  // Delete Collection
  Future<bool> deleteCollection({
    required CollectionReference colRef,
  }) async {
    try {
      final querySnapshot = await colRef.get();
      for (DocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      return true;
    } catch (err) {
      rethrow;
    }
  }
}
