// lib/config.dart
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class Config {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8000'; // 웹 브라우저
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000'; // Android 에뮬레이터
    } else if (Platform.isIOS) {
      return 'http://localhost:8000'; // iOS 에뮬레이터
    } else {
      return 'http://127.0.0.1:8000'; // 기타 경우 (웹 브라우저 또는 실제 장치)
    }
  }
}
