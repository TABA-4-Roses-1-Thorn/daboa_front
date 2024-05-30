import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'search_screen.dart';
import 'cctv_view_screen.dart';
import 'home_screen.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이상행동 기록서'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '이상행동이 감지되었어요',
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '10건',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.red),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ToggleButtons(
              isSelected: [_selectedIndex == 0, _selectedIndex == 1, _selectedIndex == 2],
              onPressed: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Month'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Week'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Day'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: _selectedIndex == 0
                  ? _buildMonthView()
                  : _selectedIndex == 1
                  ? _buildWeekView()
                  : _buildDayView(),
            ),
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
        currentIndex: 3, // Data tab 활성화
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          } else if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false,
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CCTVViewScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildMonthView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '지난 달 대비 이상행동 건수',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              '21.3% ↓',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '지난 달보다 2건 줄었어요.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('지난 달'),
                Text(
                  '15',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Text('이번 달'),
                Text(
                  '12',
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          '월별 이상행동 건수',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: List.generate(12, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      y: index == 11 ? 15 : 12,
                      colors: [index == 11 ? Colors.grey : Colors.grey[300]!],
                      width: 20,
                    ),
                  ],
                );
              }),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (double value) {
                    return '${value.toInt() + 1}월';
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '지난 주 대비 이상행동 건수',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              '21.3% ↑',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '지난 주보다 2건 늘었어요.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('지난 주'),
                Text(
                  '12',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Text('이번 주'),
                Text(
                  '15',
                  style: TextStyle(fontSize: 24, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          '주별 이상행동 건수',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: List.generate(5, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      y: index == 4 ? 15 : 12,
                      colors: [index == 4 ? Colors.grey : Colors.grey[300]!],
                      width: 20,
                    ),
                  ],
                );
              }),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (double value) {
                    return '주 ${value.toInt() + 1}';
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '어제 대비 이상행동 건수',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              '21.3% ↑',
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '어제보다 2건 늘었어요.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('어제'),
                Text(
                  '12',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                Text('오늘'),
                Text(
                  '15',
                  style: TextStyle(fontSize: 24, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          '일별 이상행동 건수',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: List.generate(7, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      y: index == 6 ? 15 : 12,
                      colors: [index == 6 ? Colors.grey : Colors.grey[300]!],
                      width: 20,
                    ),
                  ],
                );
              }),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: SideTitles(showTitles: false),
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (double value) {
                    return ['월', '화', '수', '목', '금', '토', '일'][value.toInt()];
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
