// controller/user_login_controller.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // shared_preferences 패키지 임포트
import '../models/user_login.dart';
import '../config.dart'; // config.dart 가져오기

class UserLoginController {
  static Future<bool> logIn(UserLogin userLogin) async {
    print('---------  ');
    print(userLogin.email);
    print(userLogin.password);
    try {
      final url = Uri.parse('${Config.baseUrl}/users/log-in');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(userLogin.toJson()),
      ).catchError((e) {
        print(e);
        return null;
      }); // 타임아웃 설정 증가

      print('응답 상태 코드: ${response.statusCode}');
      print('응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        // 로그인 성공 시 토큰 저장 등의 추가 작업 가능
        var responseBody = json.decode(response.body);
        String accessToken = responseBody['access_token'];
        // 예: 토큰 저장 (SharedPreferences 등)
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        return true;
      } else {
        // 로그인 실패 시 처리
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      print("로그인 중 예외 발생: $e");
      return false; // 예외 발생 시 로그인 실패 처리
    }
  }
}
