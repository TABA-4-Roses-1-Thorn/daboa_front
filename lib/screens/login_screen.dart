import 'package:flutter/material.dart';
import '../widgets/custom_button.dart' as custom_button;
import '../widgets/custom_text_field.dart' as custom_text_field;
import '../models/user_login.dart';
import '../controller/user_login_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80),
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
              isLoading
                  ? CircularProgressIndicator()
                  : custom_button.CustomButton(
                text: 'LOG IN',
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  print("로그인 버튼 클릭됨");
                  UserLogin userLogin = UserLogin(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  try {
                    bool success = await UserLoginController.logIn(userLogin);
                    print("로그인 결과: $success");
                    if (success) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      print("로그인 실패: Invalid email or password");
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
                  } catch (e) {
                    print("로그인 중 예외 발생: $e");
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Login Failed'),
                          content: Text('An error occurred. Please try again.'),
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
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
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
      ),
    );
  }
}
