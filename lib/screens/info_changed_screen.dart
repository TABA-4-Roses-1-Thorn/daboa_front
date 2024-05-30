import 'package:flutter/material.dart';

class InfoChangedScreen extends StatelessWidget {
  final VoidCallback onConfirmed;

  InfoChangedScreen({required this.onConfirmed});

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
      body: Center(
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              '정보가 변경되었습니다.',
              style: TextStyle(fontSize: 16), // 텍스트 크기 조정
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          shadowColor: Colors.grey.withOpacity(0.5),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(color: Colors.grey, thickness: 1), // 구분선 두께 조정
              Center(
                child: TextButton(
                  child: Text(
                    '확인',
                    style: TextStyle(color: Colors.blue, fontSize: 16), // 버튼 텍스트 크기 조정
                  ),
                  onPressed: () {
                    onConfirmed();
                  },
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // AlertDialog 패딩 조정
        ),
      ),
    );
  }
}
