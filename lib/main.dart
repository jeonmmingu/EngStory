import 'package:eng_story/app.dart';
import 'package:eng_story/core/utils/color/theme_manager.dart';
import 'package:eng_story/core/utils/tts_manager.dart';
import 'package:eng_story/models/cache/cached_story.dart';
import 'package:eng_story/models/cache/cached_story_script.dart';
import 'package:eng_story/models/cache/cached_sync_meta.dart';
import 'package:eng_story/models/cache/cached_ui_meta.dart';
import 'package:eng_story/providers/app_providers.dart';
import 'package:eng_story/services/local/device_info_manager.dart';
import 'package:eng_story/services/remote/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TtsManager().init();
  await DeviceInfoManager().getDeviceId(); // admin 인지 확인하기 위한 코드
  await initializeApp();

  await Future.delayed(const Duration(milliseconds: 1500));

  runApp(
    MultiProvider(
      providers: AppProviders.providers,
      child: const App(),
    ),
  );
}

// MARK: - 앱 초기화
Future<void> initializeApp() async {
  await initializeFirebase();
  await initializeHive();
  await initializeUI();
}

// MARK: - Firebase 초기화
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

// MARK: - Hive 초기화
Future<void> initializeHive() async {
  await Hive.initFlutter();
  // 자동 생성된 type adapter 등록
  Hive.registerAdapter(CachedStoryAdapter());
  Hive.registerAdapter(CachedStoryScriptAdapter());
  Hive.registerAdapter(CachedSyncMetaAdapter());
  Hive.registerAdapter(CachedUIMetaAdapter());
}

// MARK: - UI 초기화
Future<void> initializeUI() async {
  // UI 초기화 코드
  // 테마 설정
  await ThemeManager().initializeTheme();
}
