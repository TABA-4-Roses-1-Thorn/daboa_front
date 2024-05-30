import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AIAudioMentSettingsScreen extends StatefulWidget {
  @override
  _AIAudioMentSettingsScreenState createState() => _AIAudioMentSettingsScreenState();
}

class _AIAudioMentSettingsScreenState extends State<AIAudioMentSettingsScreen> {
  List<bool> selected = [];
  List<String> messages = [];
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedMessages = prefs.getStringList('messages');
    if (savedMessages != null) {
      setState(() {
        messages = List<String>.from(savedMessages); // ensure it's growable
        selected = List<bool>.filled(messages.length, false);
        controllers = messages.map((msg) => TextEditingController(text: msg)).toList();
      });
    } else {
      setState(() {
        messages = [
          '지금 즉시 나가주세요',
          '지속적인 업무 방해시 경찰에 신고하겠습니다.',
        ];
        selected = List<bool>.filled(messages.length, false);
        controllers = messages.map((msg) => TextEditingController(text: msg)).toList();
      });
    }
  }

  void _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('messages', messages);
  }

  void addMessage() {
    setState(() {
      messages = List<String>.from(messages); // ensure it's growable
      messages.add('새로운 멘트를 입력하세요');
      selected = List<bool>.from(selected); // ensure it's growable
      selected.add(false);
      controllers = List<TextEditingController>.from(controllers); // ensure it's growable
      controllers.add(TextEditingController(text: '새로운 멘트를 입력하세요'));
      _saveMessages();
    });
  }

  void removeSelectedMessages() {
    setState(() {
      List<int> indexesToRemove = [];
      for (int i = 0; i < selected.length; i++) {
        if (selected[i]) {
          indexesToRemove.add(i);
        }
      }
      for (int i = indexesToRemove.length - 1; i >= 0; i--) {
        int index = indexesToRemove[i];
        messages = List<String>.from(messages); // ensure it's growable
        messages.removeAt(index);
        selected = List<bool>.from(selected); // ensure it's growable
        selected.removeAt(index);
        controllers = List<TextEditingController>.from(controllers); // ensure it's growable
        controllers.removeAt(index);
      }
      _saveMessages();
    });
  }

  void toggleSelected(int index) {
    setState(() {
      selected[index] = !selected[index];
    });
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
                      onChanged: (text) {
                        setState(() {
                          messages[index] = text;
                          _saveMessages();
                        });
                      },
                    ),
                    trailing: Icon(Icons.volume_up),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveMessages();
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
