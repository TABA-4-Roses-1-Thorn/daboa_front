// lib/models/eventlog.dart
class EventLog {
  final int id;
  final String type;
  final String time;
  final bool state;
  final String video;

  EventLog({
    required this.id,
    required this.type,
    required this.time,
    required this.state,
    required this.video,
  });

  factory EventLog.fromJson(Map<String, dynamic> json) {
    return EventLog(
      id: json['id'],
      type: json['type'],
      time: json['time'],
      state: json['state'],
      video: json['video'],
    );
  }
}