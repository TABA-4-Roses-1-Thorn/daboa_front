import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/eventlog.dart';
import '../config.dart';

class EventLogController {
  Future<List<EventLog>> fetchEventLogs() async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/eventlog/all'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      // UTF-8로 디코딩하여 한글 깨짐 문제 해결
      final List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
      return responseData.map((data) => EventLog.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load event logs');
    }
  }
}
