import 'package:hive/hive.dart';

part 'cached_font_meta.g.dart';

@HiveType(typeId: 4)
class CachedFontMeta extends HiveObject {
  @HiveField(0)
  final String fontFamily;

  CachedFontMeta({
    required this.fontFamily,
  });
}
