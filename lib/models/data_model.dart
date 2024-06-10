import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart'; // config.dart 가져오기

class DataModel {
  Future<Map<String, dynamic>> fetchMonthlyStats() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}/analytics/monthly'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load monthly stats');
    }
  }

  Future<List<dynamic>> fetchMonthlyEventLog() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}/analytics/eventlog_monthly'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load monthly event log');
    }
  }

  Future<Map<String, dynamic>> fetchWeeklyStats() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}/analytics/weekly'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weekly stats');
    }
  }

  Future<List<dynamic>> fetchWeeklyEventLog() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}/analytics/eventlog_weekly'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weekly event log');
    }
  }

  Future<Map<String, dynamic>> fetchDailyStats() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}/analytics/daily'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load daily stats');
    }
  }

  Future<List<dynamic>> fetchDailyEventLog() async {
    final response = await http.get(Uri.parse('${Config.baseUrl}/analytics/eventlog_daily'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load daily event log');
    }
  }
}
