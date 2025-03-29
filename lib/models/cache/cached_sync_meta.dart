import 'package:hive/hive.dart';

part 'cached_sync_meta.g.dart';

@HiveType(typeId: 2)
class CachedSyncMeta extends HiveObject {
  @HiveField(0)
  final DateTime lastSyncedAt; // 유일한 변수

  CachedSyncMeta({
    required this.lastSyncedAt, // 생성자에 추가
  });
}
