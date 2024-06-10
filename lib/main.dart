// main.dart
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/logout_screen.dart';
import 'screens/delete_account_screen.dart';
import 'screens/user_info_edit_screen.dart';
import 'screens/info_changed_screen.dart';
import 'screens/feature_screen.dart';
import 'screens/ai_audio_ment_settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DABOA CCTV',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/settings': (context) => SettingsScreen(),
        '/logout': (context) => LogoutScreen(),
        '/delete_account': (context) => DeleteAccountScreen(),
        '/user_info_edit': (context) => UserInfoEditScreen(onUserInfoChanged: (userName, email) {}),
        '/info_changed': (context) => InfoChangedScreen(onConfirmed: () {}),
        '/feature': (context) => FeatureScreen(),
        '/ai_audio_ment_settings': (context) => AIAudioMentSettingsScreen(),
      },
    );
  }
}