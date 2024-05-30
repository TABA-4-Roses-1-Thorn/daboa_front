// screens/login_screen.dart
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import '../widgets/custom_button.dart' as custom_button;
import '../widgets/custom_text_field.dart' as custom_text_field;

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로고 텍스트
            Text(
              'DABOA',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to DABOA',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            custom_text_field.CustomTextField(
              labelText: 'Email',
            ),
            SizedBox(height: 20),
            custom_text_field.CustomTextField(
              labelText: 'Password',
              isPassword: true,
            ),
            SizedBox(height: 20),
            custom_button.CustomButton(
              text: 'Log in',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
