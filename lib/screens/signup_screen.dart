// screens/signup_screen.dart
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart' as custom_button;
import '../widgets/custom_text_field.dart' as custom_text_field;
import '../models/user.dart';
import '../controller/user_controller.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
              controller: nameController, // controller 추가
            ),
            SizedBox(height: 20),
            custom_text_field.CustomTextField(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              controller: emailController, // controller 추가
            ),
            SizedBox(height: 20),
            custom_text_field.CustomTextField(
              labelText: 'Password',
              isPassword: true,
              prefixIcon: Icon(Icons.lock),
              controller: passwordController, // controller 추가
            ),
            SizedBox(height: 20),
            custom_text_field.CustomTextField(
              labelText: 'Confirm Password',
              isPassword: true,
              prefixIcon: Icon(Icons.lock),
              controller: confirmPasswordController, // controller 추가
            ),
            SizedBox(height: 20),
            custom_button.CustomButton(
              text: 'CREATE',
              onPressed: () async {
                if (passwordController.text == confirmPasswordController.text) {
                  User user = User(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  bool success = await UserController.signUp(user);
                  if (success) {
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    // 회원가입 실패 처리 (예: 오류 메시지 표시)
                  }
                } else {
                  // 비밀번호 불일치 처리 (예: 오류 메시지 표시)
                }
              },
            ),
            SizedBox(height: 40),
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
