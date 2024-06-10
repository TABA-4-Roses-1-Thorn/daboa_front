import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controller/data_controller.dart';
import 'search_screen.dart';
import 'cctv_view_screen.dart';
import 'home_screen.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final DataController _dataController = DataController();
  int _selectedIndex = 0;
  Map<String, dynamic>? stats;
  List<dynamic>? eventLog;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    switch (_selectedIndex) {
      case 0:
        _dataController.getMonthlyStats().then((data) {
          setState(() {
            stats = data;
          });
        });
        _dataController.getMonthlyEventLog().then((data) {
          setState(() {
            eventLog = data;
          });
        });
        break;
      case 1:
        _dataController.getWeeklyStats().then((data) {
          setState(() {
            stats = data;
          });
        });
        _dataController.getWeeklyEventLog().then((data) {
          setState(() {
            eventLog = data;
          });
        });
        break;
      case 2:
        _dataController.getDailyStats().then((data) {
          setState(() {
            stats = data;
          });
        });
        _dataController.getDailyEventLog().then((data) {
          setState(() {
            eventLog = data;
          });
        });
        break;
    }
  }

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
                  _fetchData();
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
    return stats == null || eventLog == null
        ? Center(child: CircularProgressIndicator())
        : Column(
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
              '${stats!['change']}% ${stats!['change'] > 0 ? '↑' : '↓'}',
              style: TextStyle(
                color: stats!['change'] > 0 ? Colors.red : Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '지난 달보다 ${stats!['current_month'] - stats!['previous_month']}건 ${stats!['current_month'] - stats!['previous_month'] > 0 ? '늘었어요' : '줄었어요'}.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Column(
              children: [
                Text('지난 달'),
                Text(
                  '${stats!['previous_month']}',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(width: 32), // 여백 조정
            Column(
              children: [
                Text('이번 달'),
                Text(
                  '${stats!['current_month']}',
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
              barGroups: List.generate(eventLog!.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      y: eventLog![index]['count'].toDouble(),
                      colors: [Colors.grey],
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
                    return '${eventLog![value.toInt()]['period']}';
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
    return stats == null || eventLog == null
        ? Center(child: CircularProgressIndicator())
        : Column(
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
              '${stats!['change']}% ${stats!['change'] > 0 ? '↑' : '↓'}',
              style: TextStyle(
                color: stats!['change'] > 0 ? Colors.red : Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '지난 주보다 ${stats!['current_week'] - stats!['previous_week']}건 ${stats!['current_week'] - stats!['previous_week'] > 0 ? '늘었어요' : '줄었어요'}.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Column(
              children: [
                Text('지난 주'),
                Text(
                  '${stats!['previous_week']}',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(width: 32), // 여백 조정
            Column(
              children: [
                Text('이번 주'),
                Text(
                  '${stats!['current_week']}',
                  style: TextStyle(fontSize: 24, color: Colors.blue),
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
              barGroups: List.generate(eventLog!.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      y: eventLog![index]['count'].toDouble(),
                      colors: [Colors.grey],
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
                    return '${eventLog![value.toInt()]['period']}';
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
    return stats == null || eventLog == null
        ? Center(child: CircularProgressIndicator())
        : Column(
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
              '${stats!['change']}% ${stats!['change'] > 0 ? '↑' : '↓'}',
              style: TextStyle(
                color: stats!['change'] > 0 ? Colors.red : Colors.blue,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8),
            Text(
              '어제보다 ${stats!['current_day'] - stats!['previous_day']}건 ${stats!['current_day'] - stats!['previous_day'] > 0 ? '늘었어요' : '줄었어요'}.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Column(
              children: [
                Text('어제'),
                Text(
                  '${stats!['previous_day']}',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(width: 32), // 여백 조정
            Column(
              children: [
                Text('오늘'),
                Text(
                  '${stats!['current_day']}',
                  style: TextStyle(fontSize: 24, color: Colors.blue),
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
              barGroups: List.generate(eventLog!.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      y: eventLog![index]['count'].toDouble(),
                      colors: [Colors.grey],
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
