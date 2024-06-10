import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/audio_message.dart';
import '../config.dart'; // config.dart 가져오기

class AudioMessageController {
  Future<List<AudioMessage>> fetchMessages() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}/setting_ai_message/ai_audio_ment_settings_screen'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((message) => AudioMessage.fromJson(message)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<AudioMessage> addMessage(AudioMessage message) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/setting_ai_message/ai_audio_ment_settings_screen'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(message.toJson()),
    );
    if (response.statusCode == 200) {
      return AudioMessage.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add message');
    }
  }

  Future<void> deleteMessage(int id) async {
    final response = await http.delete(
      Uri.parse('${Config.baseUrl}/setting_ai_message/ai_audio_ment_settings_screen/$id'),
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to delete message');
    }
  }

  Future<void> updateMessage(AudioMessage message) async {
    final response = await http.patch(
      Uri.parse('${Config.baseUrl}/setting_ai_message/ai_audio_ment_settings_screen/${message.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(message.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update message');
    }
  }
}
