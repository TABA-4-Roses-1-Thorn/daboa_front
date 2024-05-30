import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 2),
            Text(
              'DABOA',
              style: TextStyle(
                fontSize: 65,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900], // 남색
              ),
            ),
            Spacer(flex: 1),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'The Worlds Leading\n',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFB1AEAE), // B1AEAE 색깔
                    ),
                  ),
                  TextSpan(
                    text: 'Smart unmanned store\n',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFF99C34), // F99C34 색깔
                    ),
                  ),
                  TextSpan(
                    text: 'Security System',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFF4C7EFF), // 4C7EFF 색깔
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Image.asset(
              'assets/logo.png',
              height: 150,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Text('Image not found');
              },
            ),
            Spacer(flex: 2),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // 버튼 배경색
                foregroundColor: Colors.white, // 버튼 텍스트 색상
                shadowColor: Colors.grey.withOpacity(0.5), // 그림자 색상
                elevation: 10, // 그림자 높이
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                minimumSize: Size(150, 50), // 버튼 최소 크기
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text('Log in', style: TextStyle(fontSize: 16)),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
