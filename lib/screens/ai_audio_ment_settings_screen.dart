import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../controller/audio_message_controller.dart';
import '../models/audio_message.dart';

class AIAudioMentSettingsScreen extends StatefulWidget {
  @override
  _AIAudioMentSettingsScreenState createState() => _AIAudioMentSettingsScreenState();
}

class _AIAudioMentSettingsScreenState extends State<AIAudioMentSettingsScreen> {
  List<AudioMessage> messages = [];
  List<bool> selected = [];
  List<TextEditingController> controllers = [];
  final AudioMessageController controller = AudioMessageController();
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    try {
      List<AudioMessage> fetchedMessages = await controller.fetchMessages();
      setState(() {
        messages = List<AudioMessage>.from(fetchedMessages); // Ensure it's growable
        selected = List<bool>.filled(messages.length, false, growable: true);
        controllers = List<TextEditingController>.from(
          fetchedMessages.map((msg) => TextEditingController(text: msg.content)),
        );
      });
    } catch (e) {
      print(e);
    }
  }

  void addMessage() {
    setState(() {
      messages.add(AudioMessage(id: 0, content: '')); // ID는 백엔드에서 설정됨
      selected.add(false);
      controllers.add(TextEditingController());
    });
  }

  void saveAllMessages() async {
    for (int i = 0; i < messages.length; i++) {
      String text = controllers[i].text;
      messages[i].content = text;

      try {
        if (messages[i].id == 0) {
          // 새로운 메시지 추가
          AudioMessage addedMessage = await controller.addMessage(messages[i]);
          setState(() {
            messages[i] = addedMessage;
          });
        } else {
          // 기존 메시지 업데이트
          await controller.updateMessage(messages[i]);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void removeSelectedMessages() async {
    for (int i = selected.length - 1; i >= 0; i--) {
      if (selected[i]) {
        try {
          await controller.deleteMessage(messages[i].id);
          setState(() {
            messages.removeAt(i);
            selected.removeAt(i);
            controllers.removeAt(i);
          });
        } catch (e) {
          print(e);
        }
      }
    }
  }

  void toggleSelected(int index) {
    setState(() {
      selected[index] = !selected[index];
    });
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI 음성 송출 멘트 설정'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: addMessage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('추가'),
                ),
                ElevatedButton(
                  onPressed: removeSelectedMessages,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('삭제'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(
                        selected[index] ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                        color: selected[index] ? Colors.red : Colors.black,
                      ),
                      onPressed: () {
                        toggleSelected(index);
                      },
                    ),
                    title: TextField(
                      controller: controllers[index],
                      decoration: InputDecoration(
                        hintText: "멘트를 입력하세요",
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.volume_up),
                      onPressed: () {
                        speak(messages[index].content);
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                saveAllMessages();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
              ),
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}