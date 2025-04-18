import 'package:hive/hive.dart';

part 'cached_read_option.g.dart';

@HiveType(typeId: 5) // 다른 모델과 겹치지 않도록 typeId 설정
class CachedReadOption extends HiveObject {
  @HiveField(0)
  double speechSpeed;

  CachedReadOption({
    required this.speechSpeed,
  });
}
