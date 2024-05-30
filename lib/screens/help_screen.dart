import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('기타')),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Divider(color: Colors.grey),
            ListTile(
              title: Text('이용약관'),
              onTap: () {
                // 이용약관 화면으로 이동
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text('오픈소스 라이선스'),
              onTap: () {
                // 오픈소스 라이선스 화면으로 이동
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text('개인정보 처리방침'),
              onTap: () {
                // 개인정보 처리방침 화면으로 이동
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text('고객센터/FAQ'),
              onTap: () {
                // 고객센터/FAQ 화면으로 이동
              },
            ),
          ],
        ),
      ),
    );
  }
}
