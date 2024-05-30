// screens/delete_account_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart';

class DeleteAccountScreen extends StatelessWidget {
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
          title: Center(child: Text('정말 탈퇴하시겠습니까?')),
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
                          style: TextStyle(color: Colors.red, fontSize: 18),
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
                          style: TextStyle(color: Colors.blue, fontSize: 18),
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
        ),
      ),
    );
  }
}
