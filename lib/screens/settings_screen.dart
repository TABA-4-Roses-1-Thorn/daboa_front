import 'package:flutter/material.dart';
import 'logout_screen.dart';
import 'delete_account_screen.dart';
import 'user_info_edit_screen.dart';
import 'help_screen.dart';
import 'feature_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true; // 알림 활성화 상태 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('환경설정'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              title: Text(
                'Junhyoung Kim',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('junhyoung@gmail.com'),
              trailing: Icon(Icons.edit_note, color: Colors.blue),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInfoEditScreen(
                          onUserInfoChanged: (userName, email) {})),
                );
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image.asset(
                  'assets/icons/notifications.png',
                  height: 20, // 아이콘 크기 조절
                  width: 20, // 아이콘 크기 조절
                ),
              ),
              title: Text('알림'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value; // 상태 변경
                  });
                },
                activeColor: Colors.blue, // 스위치 활성화 색상
              ),
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image.asset(
                  'assets/icons/features.png',
                  height: 20, // 아이콘 크기 조절
                  width: 20, // 아이콘 크기 조절
                ),
              ),
              title: Text('기능'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeatureScreen()),
                );
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image.asset(
                  'assets/icons/help.png',
                  height: 20, // 아이콘 크기 조절
                  width: 20, // 아이콘 크기 조절
                ),
              ),
              title: Text('기타'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpScreen()),
                );
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Image.asset(
                  'assets/icons/logout.png',
                  height: 20, // 아이콘 크기 조절
                  width: 20, // 아이콘 크기 조절
                ),
              ),
              title: Text('로그아웃'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogoutScreen()),
                );
              },
            ),
            Divider(color: Colors.grey),
            Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeleteAccountScreen()),
                  );
                },
                child: Text(
                  '회원탈퇴',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}