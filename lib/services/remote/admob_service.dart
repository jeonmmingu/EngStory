import 'dart:io';

import 'package:eng_story/router/router.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  //배너광고
  //앱 개발시 테스트광고 ID로 입력
  static String? get bannerAdUnitId {

    if (isAdmin) { return null; }

    if (Platform.isAndroid) {
      // TODO: 배너 광고 ID 변경
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
      // 변경 완료
      // return 'ca-app-pub-6460600693792652/2876639841';
    }
    return null;
  }

  //전면 광고
  static String? get interstitialAdUnitId {
    if (isAdmin) { return null; }
    if (Platform.isAndroid) {
      // TODO: 전면 광고 ID 변경
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      // TODO: 전면 광고 ID 변경
      return 'ca-app-pub-3940256099942544/4411468910';
      // 변경 완료
      // return 'ca-app-pub-6460600693792652/1899434246';
    }
    return null;
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad fail to load: $error');
    },
    onAdOpened: (ad) => debugPrint('Ad opened'),
    onAdClosed: (ad) => debugPrint('Ad closed'),
  );
}
