import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controller/eventlog_controller.dart';
import '../models/eventlog.dart';
import 'cctv_view_screen.dart';
import 'data_screen.dart';
import 'home_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedType;
  List<EventLog> _dataList = [];
  final EventLogController _controller = EventLogController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEventLogs();
  }

  Future<void> _fetchEventLogs() async {
    try {
      List<EventLog> logs = await _controller.fetchEventLogs();
      setState(() {
        _dataList = logs;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      print('Error fetching event logs: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<EventLog> get _filteredList {
    return _dataList.where((item) {
      DateTime itemDate = DateTime.parse(item.time);
      bool matchesDateRange = (_startDate == null || itemDate.isAfter(_startDate!)) &&
          (_endDate == null || itemDate.isBefore(_endDate!));
      bool matchesType = _selectedType == null || _selectedType == '모든 타입' || item.type == _selectedType;
      return matchesDateRange && matchesType;
    }).toList();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2020);
    DateTime lastDate = DateTime(2101);
    TimeOfDay initialTime = TimeOfDay.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _startDate = selectedDateTime;
          _endDate = selectedDateTime.add(Duration(hours: 1)); // 예시로 1시간 후를 끝 날짜로 설정
        });
      }
    }
  }

  void _showTypeAndDateFilter(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? tempType = _selectedType;
        DateTime? tempStartDate = _startDate;
        DateTime? tempEndDate = _endDate;

        return AlertDialog(
          title: Text('필터 옵션'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('시작 날짜'),
                  subtitle: Text(tempStartDate != null
                      ? DateFormat('yyyy/MM/dd').format(tempStartDate)
                      : '선택되지 않음'),
                  onTap: () async {
                    DateTime? pickedDate = await _selectDate(context);
                    if (pickedDate != null) {
                      setState(() {
                        tempStartDate = pickedDate;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text('끝 날짜'),
                  subtitle: Text(tempEndDate != null
                      ? DateFormat('yyyy/MM/dd').format(tempEndDate)
                      : '선택되지 않음'),
                  onTap: () async {
                    DateTime? pickedDate = await _selectDate(context);
                    if (pickedDate != null) {
                      setState(() {
                        tempEndDate = pickedDate;
                      });
                    }
                  },
                ),
                ListTile(
                  title: Text('유형'),
                  subtitle: DropdownButton<String>(
                    value: tempType,
                    isExpanded: true,
                    items: <String>['무단취침', '절도', '이상행동', '모든 타입']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        tempType = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('적용'),
              onPressed: () {
                setState(() {
                  _selectedType = tempType;
                  _startDate = tempStartDate;
                  _endDate = tempEndDate;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2020);
    DateTime lastDate = DateTime(2101);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    return picked;
  }

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('yyyy/MM/dd HH:mm:ss').format(dateTime);
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
        padding: const EdgeInsets.all(16.0), // 여기에 padding 값을 설정
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow, color: Colors.blue),
                  onPressed: () {
                    _selectDateTime(context); // Play button pressed
                  },
                ),
                IconButton(
                  icon: Icon(Icons.filter_alt, color: Colors.blue),
                  onPressed: () {
                    _showTypeAndDateFilter(context); // Filter button pressed
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'List',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Record',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 2, child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 3, child: Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 1, child: Text('State', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(flex: 2, child: Text('Video', style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _filteredList.length, // 필터된 데이터 수
                        itemBuilder: (context, index) {
                          var item = _filteredList[index];
                          IconData stateIcon = item.state ? Icons.check_circle : Icons.hourglass_empty;
                          Color iconColor = item.state ? Colors.black : Colors.black;
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(flex: 2, child: Text(item.type)),
                                  Expanded(flex: 3, child: Text(_formatDateTime(item.time))),
                                  Expanded(flex: 1, child: Icon(stateIcon, color: iconColor)),
                                  Expanded(
                                    flex: 2,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text('click'),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(30, 30), // 버튼 크기 조절
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(horizontal: 7.0), // 버튼 내부 여백 조정
                                        textStyle: TextStyle(fontSize: 14), // 텍스트 크기 조정
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.grey), // 리스트 사이에 구분선 추가
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
        currentIndex: 1, // Search tab 활성화
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
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