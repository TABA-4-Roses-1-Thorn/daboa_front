import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Config {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://15.164.245.73:8000'; // 웹 브라우저
    } else if (Platform.isAndroid) {
      // 에뮬레이터와 실제 기기 구분
      return const bool.fromEnvironment('IS_EMULATOR', defaultValue: false)
          ? 'http://10.0.2.2:8000' // Android 에뮬레이터
          : 'http://43.202.59.51:8000'; // 실제 안드로이드 기기 (새로운 IP 주소-여기에 수정하면 됨)
    } else if (Platform.isIOS) {
      return 'http://localhost:8000'; // iOS 에뮬레이터
    } else {
      return 'http://127.0.0.1:8000'; // 기타 경우
    }
  }
}