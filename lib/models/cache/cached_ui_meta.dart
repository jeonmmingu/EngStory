import 'package:hive/hive.dart';

part 'cached_ui_meta.g.dart';

@HiveType(typeId: 3) // Replace 0 with a unique typeId for your app
class CachedUIMeta extends HiveObject {
  @HiveField(0)
  final String themeColor;

  CachedUIMeta({
    required this.themeColor,
  });
}
