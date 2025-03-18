import 'package:hive/hive.dart';

class CacheService<T extends HiveObject> {
  final String boxName;

  CacheService(this.boxName);

  /// 🔹 **Hive Box 열기**
  Future<Box<T>> _openBox() async {
    return await Hive.openBox<T>(boxName);
  }

  // ------------------- 📌 Create & Update -------------------

  /// 🔹 **객체 저장 (Create & Update)**
  Future<void> saveItem(String key, T item) async {
    final box = await _openBox();
    await box.put(key, item);
  }

  // ------------------- 📌 Read -------------------

  /// 🔹 **모든 객체 가져오기 (Read All)**
  Future<List<T>> getAllItems() async {
    final box = await _openBox();
    return box.values.toList();
  }

  /// 🔹 **특정 객체 가져오기 (Read)**
  Future<T?> getItemByKey(String key) async {
    final box = await _openBox();
    return box.get(key);
  }

  // ------------------- 📌 Delete -------------------

  /// 🔹 **특정 객체 삭제 (Delete)**
  Future<void> deleteItem(String key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  /// 🔹 **전체 캐시 삭제 (Clear All)**
  Future<void> clearCache() async {
    final box = await _openBox();
    await box.clear();
  }
}