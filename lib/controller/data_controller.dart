import '../models/data_model.dart';

class DataController {
  final DataModel _dataModel = DataModel();

  Future<Map<String, dynamic>> getMonthlyStats() {
    return _dataModel.fetchMonthlyStats();
  }

  Future<List<dynamic>> getMonthlyEventLog() {
    return _dataModel.fetchMonthlyEventLog();
  }

  Future<Map<String, dynamic>> getWeeklyStats() {
    return _dataModel.fetchWeeklyStats();
  }

  Future<List<dynamic>> getWeeklyEventLog() {
    return _dataModel.fetchWeeklyEventLog();
  }

  Future<Map<String, dynamic>> getDailyStats() {
    return _dataModel.fetchDailyStats();
  }

  Future<List<dynamic>> getDailyEventLog() {
    return _dataModel.fetchDailyEventLog();
  }
}
