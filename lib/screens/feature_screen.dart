import 'package:flutter/material.dart';
import 'ai_audio_ment_settings_screen.dart';

class FeatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기능'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          leading: Icon(Icons.featured_play_list),
          title: Text('AI 음성 송출 멘트 설정'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AIAudioMentSettingsScreen()),
            );
          },
        ),
      ),
    );
  }
}
