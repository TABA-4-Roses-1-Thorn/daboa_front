import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';

class UserSettingModel {
  Future<Map<String, dynamic>> fetchUserInfo() async {
    final url = Uri.parse('${Config.baseUrl}/user_info');
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
