import 'package:flutter/material.dart';
import 'data_screen.dart';
import 'settings_screen.dart';
import 'cctv_view_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          children: [
            SizedBox(height: 20), // 아이콘을 아래로 내리기 위한 여백 추가
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 24,
                  child: IconButton(
                    icon: Image.asset('assets/icons/settings.png', height: 24, width: 24),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsScreen()),
                      );
                    },
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 24,
                  child: IconButton(
                    icon: Image.asset('assets/icons/bar_chart.png', height: 24, width: 24),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DataScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/icons/daboa.png',
                height: 100, // 이미지 높이 설정
                width: 200, // 이미지 너비 설정
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Text('Image not found');
                },
              ),
            ),
            SizedBox(height: 10), // 버튼과 이미지 사이의 여백
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CCTVViewScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4C7EFF),
                foregroundColor: Colors.white,
                shadowColor: Colors.grey.withOpacity(0.5),
                elevation: 10,
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                minimumSize: Size(double.infinity, 150), // 버튼 최소 크기 증가
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CCTV',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // 글씨 크기 증가
                    ),
                    Text(
                      'Real-time AI monitoring',
                      style: TextStyle(fontSize: 18), // 글씨 크기 증가
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shadowColor: Colors.grey.withOpacity(0.5),
                elevation: 10,
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                minimumSize: Size(double.infinity, 150), // 버튼 최소 크기 증가
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Record\nthe time point',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // 글씨 크기 증가
                    ),
                    Text(
                      'abnormal behavior pattern',
                      style: TextStyle(fontSize: 18), // 글씨 크기 증가
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
            label: 'CCTV',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage),
            label: 'Data',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CCTVViewScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DataScreen()),
            );
          }
        },
      ),
    );
  }
}
