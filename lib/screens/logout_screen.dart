// screens/logout_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart';

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('환경설정'),
        backgroundColor: Colors.white, // AppBar 배경색 흰색으로 설정
        foregroundColor: Colors.black, // AppBar 텍스트 색상 검정색으로 설정
        elevation: 1, // AppBar 하단의 구분선 효과
      ),
      backgroundColor: Colors.white, // 배경색 흰색으로 설정
      body: Center(
        child: AlertDialog(
          backgroundColor: Colors.white, // AlertDialog 배경색 흰색으로 설정
          title: Center(
            child: Text(
              '정말 로그아웃 하시겠습니까?',
              style: TextStyle(fontSize: 16), // 텍스트 크기 조정
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5, // 그림자 효과 추가
          shadowColor: Colors.grey.withOpacity(0.5),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(color: Colors.grey), // 제목과 버튼 사이의 구분선
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        child: Text(
                          '예',
                          style: TextStyle(color: Colors.red, fontSize: 16), // 버튼 텍스트 크기 조정
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                                (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ),
                    VerticalDivider(color: Colors.grey), // 버튼들 사이의 구분선
                    Expanded(
                      child: TextButton(
                        child: Text(
                          '아니오',
                          style: TextStyle(color: Colors.blue, fontSize: 16), // 버튼 텍스트 크기 조정
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
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
