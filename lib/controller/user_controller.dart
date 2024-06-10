// controllers/user_controller.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';
import '../config.dart'; // config.dart 가져오기

class UserController {
  static Future<bool> signUp(User user) async {
    final url = Uri.parse('${Config.baseUrl}/users/sign-up');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      // Handle different status codes or errors as needed
      return false;
    }
  }
}
