// screens/login_screen.dart
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart' as custom_button;
import '../widgets/custom_text_field.dart' as custom_text_field;
import '../models/user_login.dart';
import '../controller/user_login_controller.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              "Welcome Back!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Log in to your account",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            custom_text_field.CustomTextField(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              controller: emailController,
            ),
            SizedBox(height: 20),
            custom_text_field.CustomTextField(
              labelText: 'Password',
              isPassword: true,
              prefixIcon: Icon(Icons.lock),
              controller: passwordController,
            ),
            SizedBox(height: 20),
            custom_button.CustomButton(
              text: 'LOG IN',
              onPressed: () async {
                UserLogin userLogin = UserLogin(
                  email: emailController.text,
                  password: passwordController.text,
                );

                bool success = await UserLoginController.logIn(userLogin);
                if (success) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // 로그인 실패 처리 (예: 오류 메시지 표시)
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Login Failed'),
                        content: Text('Invalid email or password.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don’t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(
                    'Sign Up Here',
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