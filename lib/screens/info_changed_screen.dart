import 'package:flutter/material.dart';

class InfoChangedScreen extends StatelessWidget {
  final VoidCallback onConfirmed;

  InfoChangedScreen({required this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('환경설정'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: Center(child: Text('정보가 변경되었습니다.')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          shadowColor: Colors.grey.withOpacity(0.5),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Divider(color: Colors.grey),
              Center(
                child: TextButton(
                  child: Text(
                    '확인',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  onPressed: () {
                    onConfirmed();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
