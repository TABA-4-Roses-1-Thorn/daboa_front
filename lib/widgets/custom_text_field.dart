// widgets/custom_text_field.dart
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool isPassword;
  final Icon? prefixIcon; // prefixIcon 추가
  final TextEditingController controller; // controller 추가

  CustomTextField({
    required this.labelText,
    this.isPassword = false,
    this.prefixIcon,
    required this.controller, // controller 추가
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // controller 추가
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        prefixIcon: prefixIcon, // prefixIcon 추가
      ),
      obscureText: isPassword,
    );
  }
}
