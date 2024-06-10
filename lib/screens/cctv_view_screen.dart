import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io';
import '../controller/cctv_controller.dart';
import '../models/audio_message.dart';
import '../controller/audio_message_controller.dart';
import 'data_screen.dart';
import 'search_screen.dart';
import 'home_screen.dart';
import '../config.dart'; // Config 클래스가 정의된 파일을 import 합니다.

class CCTVViewScreen extends StatefulWidget {
  @override
  _CCTVViewScreenState createState() => _CCTVViewScreenState();
}

class _CCTVViewScreenState extends State<CCTVViewScreen> {
  final CCTVController _cctvController = CCTVController();
  final FlutterTts flutterTts = FlutterTts();
  final AudioMessageController _audioMessageController = AudioMessageController();
  int _selectedIndex = 2; // Default to the CCTV tab
  List<String> messages = [];
  List<AudioMessage> aiMessages = [];
  Stream<List<int>>? _cctvStream;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _fetchCCTVData();
  }

  void _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedMessages = prefs.getStringList('messages');
    if (savedMessages != null) {
      setState(() {
        messages = List<String>.from(savedMessages); // ensure it's growable
      });
    } else {
      setState(() {
        messages = [
          '지금 즉시 나가주세요',
          '지속적인 업무 방해시 경찰에 신고하겠습니다.',
        ];
      });
    }
  }

  Future<void> _fetchAIMessages() async {
    try {
      List<AudioMessage> fetchedMessages = await _audioMessageController.fetchMessages();
      setState(() {
        aiMessages = fetchedMessages;
      });
    } catch (e) {
      log('Error fetching AI messages: $e');
    }
  }

  Future<void> _fetchCCTVData() async {
    try {
      Stream<List<int>> stream = await _cctvController.fetchCCTVStream();
      setState(() {
        _cctvStream = stream;
        _isLoading = false;
      });
    } catch (e) {
      log('Failed to fetch CCTV data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
      } else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DataScreen()),
        );
      } else if (index == 0) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
        );
      }
    });
  }

  void _showVoiceTransmissionModal(BuildContext context) async {
    await _fetchAIMessages(); // Fetch AI messages when the modal is shown
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (context) => _buildBottomSheet(context),
    );
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("ko-KR");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      log('Video picked: ${file.name}');
      _uploadVideo(File(file.path!));
    } else {
      log('User canceled the picker');
    }
  }

  Future<void> _uploadVideo(File videoFile) async {
    final url = Uri.parse('${Config.baseUrl}/stream/upload');
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', videoFile.path));  // 'video' -> 'file'

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        log('Video uploaded successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Video uploaded successfully')),
        );
      } else {
        log('Failed to upload video: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload video')),
        );
      }
    } catch (e) {
      log('Error uploading video: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading video')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('실시간 CCTV 영상'),
            IconButton(
              icon: Icon(Icons.upload_file, color: Colors.black),
              onPressed: _pickVideo,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Expanded CCTV video section
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Stack(
                  children: [
                    StreamBuilder<List<int>>(
                      stream: _cctvStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No data'));
                        } else {
                          Uint8List bytes = Uint8List.fromList(snapshot.data!);
                          try {
                            return Image.memory(bytes, fit: BoxFit.cover);
                          } catch (e) {
                            return Center(child: Text('Invalid image data'));
                          }
                        }
                      },
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: Colors.white,
                        child: Text(
                          '실시간 촬영중',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Information and mic icon section inside a box
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
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
                  children: [
                    Expanded(
                      child: Text(
                        '준형이네 아이스크림 할인점',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.mic, color: Colors.blue),
                          onPressed: () {
                            _showVoiceTransmissionModal(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '1번 카메라',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              // Implement the real-time audio transmission logic here
              // Example: _speak(selectedMessage);
              await _speak("음성 송출을 시작합니다");
            },
            icon: Icon(Icons.mic),
            label: Text('음원 송출  '),
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
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: aiMessages.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.volume_up, color: Colors.blue),
                title: Text(aiMessages[index].content),
                onTap: () async {
                  await _speak(aiMessages[index].content);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
