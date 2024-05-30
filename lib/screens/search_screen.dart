import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart';
import 'cctv_view_screen.dart';
import 'data_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedType;

  final List<Map<String, dynamic>> _dataList = [
    {'type': '무단 취침', 'time': '2024/04/20 00:32:14', 'state': 'check'},
    {'type': '절도', 'time': '2024/04/21 00:32:14', 'state': 'loading'},
    {'type': '이상 행동', 'time': '2024/04/22 00:32:14', 'state': 'check'},
    {'type': '이상 행동', 'time': '2024/04/22 00:32:14', 'state': 'check'},
    {'type': '무단 취침', 'time': '2024/03/22 13:50:14', 'state': 'loading'},
    {'type': '절도', 'time': '2024/03/6 07:32:14', 'state': 'check'},
    // 더 많은 예시 데이터 추가
  ];

  List<Map<String, dynamic>> get _filteredList {
    return _dataList.where((item) {
      DateTime itemDate = DateFormat('yyyy/MM/dd HH:mm:ss').parse(item['time']);
      bool matchesDateRange = (_startDate == null || itemDate.isAfter(_startDate!)) &&
          (_endDate == null || itemDate.isBefore(_endDate!));
      bool matchesType = _selectedType == null || _selectedType == '모든 타입' || item['type'] == _selectedType;
      return matchesDateRange && matchesType;
    }).toList();
  }

  void _showDateTimeFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: DateTimeFilter(),
        );
      },
    );
  }

  void _showTypeAndDateFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: TypeAndDateFilter(
            onFilterChanged: (startDate, endDate, selectedType) {
              setState(() {
                _startDate = startDate;
                _endDate = endDate;
                _selectedType = selectedType;
              });
            },
          ),
        );
      },
    );
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow, color: Colors.blue),
                  onPressed: () {
                    _showDateTimeFilter(context); // Play button pressed
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
            Expanded(
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
                          IconData stateIcon = item['state'] == 'check'
                              ? Icons.check_circle
                              : Icons.hourglass_empty;
                          Color iconColor = item['state'] == 'check'
                              ? Colors.black
                              : Colors.black;
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(flex: 2, child: Text(item['type'])),
                                  Expanded(flex: 3, child: Text(item['time'])),
                                  Expanded(flex: 1, child: Icon(stateIcon, color: iconColor)),
                                  Expanded(
                                    flex: 2,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text('click'),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(60, 30), // 버튼 크기 조절
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
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

class DateTimeFilter extends StatefulWidget {
  @override
  _DateTimeFilterState createState() => _DateTimeFilterState();
}

class _DateTimeFilterState extends State<DateTimeFilter> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 배경색 설정
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("Select Date"),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null && pickedDate != _selectedDate) {
                setState(() {
                  _selectedDate = pickedDate;
                });
              }
            },
          ),
          ListTile(
            title: Text(DateFormat('MMMM dd, yyyy').format(_selectedDate)),
          ),
          ListTile(
            title: Text("Select Time"),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: _selectedTime,
              );
              if (pickedTime != null && pickedTime != _selectedTime) {
                setState(() {
                  _selectedTime = pickedTime;
                });
              }
            },
          ),
          ListTile(
            title: Text(_selectedTime.format(context)),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // 필터링 값을 사용하고 싶으면 여기서 데이터를 전달하세요.
            },
            child: Text('확인'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              textStyle: TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class TypeAndDateFilter extends StatefulWidget {
  final Function(DateTime?, DateTime?, String?) onFilterChanged;

  TypeAndDateFilter({required this.onFilterChanged});

  @override
  _TypeAndDateFilterState createState() => _TypeAndDateFilterState();
}

class _TypeAndDateFilterState extends State<TypeAndDateFilter> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 배경색 설정
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("Select Start Date"),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _startDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null && pickedDate != _startDate) {
                setState(() {
                  _startDate = pickedDate;
                });
              }
            },
          ),
          ListTile(
            title: Text(DateFormat('MMMM dd, yyyy').format(_startDate)),
          ),
          ListTile(
            title: Text("Select End Date"),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _endDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null && pickedDate != _endDate) {
                setState(() {
                  _endDate = pickedDate;
                });
              }
            },
          ),
          ListTile(
            title: Text(DateFormat('MMMM dd, yyyy').format(_endDate)),
          ),
          ListTile(
            title: Text("Select Type"),
            trailing: Icon(Icons.keyboard_arrow_down),
            onTap: () async {
              String? pickedType = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Text('Select Type'),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, '무단 취침');
                        },
                        child: Text('무단 취침'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, '절도');
                        },
                        child: Text('절도'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, '이상 행동');
                        },
                        child: Text('이상 행동'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, '모든 타입');
                        },
                        child: Text('모든 타입'),
                      ),
                    ],
                  );
                },
              );
              if (pickedType != null && pickedType != _selectedType) {
                setState(() {
                  _selectedType = pickedType;
                });
              }
            },
          ),
          if (_selectedType != null)
            ListTile(
              title: Text('Selected Type: $_selectedType'),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.onFilterChanged(_startDate, _endDate, _selectedType);
              Navigator.pop(context);
            },
            child: Text('확인'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              textStyle: TextStyle(fontSize: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
