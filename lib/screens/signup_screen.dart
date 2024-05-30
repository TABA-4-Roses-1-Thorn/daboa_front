// screens/signup_screen.dart
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart' as custom_button;
import '../widgets/custom_text_field.dart' as custom_text_field;

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Let’s Get Started!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Create an account on Daboa to get all features",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            custom_text_field.CustomTextField(
              labelText: 'Name',
              prefixIcon: Icon(Icons.person),
            ),
            SizedBox(height: 20),
            custom_text_field.CustomTextField(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            SizedBox(height: 20),
            custom_text_field.CustomTextField(
              labelText: 'Password',
              isPassword: true,
              prefixIcon: Icon(Icons.lock),
            ),
            SizedBox(height: 20),
            custom_text_field.CustomTextField(
              labelText: 'Confirm Password',
              isPassword: true,
              prefixIcon: Icon(Icons.lock),
            ),
            SizedBox(height: 20),
            custom_button.CustomButton(
              text: 'CREATE',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
            SizedBox(height: 40), // 문구를 더 아래로 이동시키기 위해 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Login Here',
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
