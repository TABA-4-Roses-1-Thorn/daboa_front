class AudioMessage {
  int id;
  String content;

  AudioMessage({required this.id, required this.content});

  factory AudioMessage.fromJson(Map<String, dynamic> json) {
    return AudioMessage(
      id: json['id'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
    };
  }
}
