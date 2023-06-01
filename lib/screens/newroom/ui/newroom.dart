import 'package:flutter/material.dart';
import 'package:vendoo/screens/chat/ui/chat.dart';

class ChatRoomCreationPage extends StatefulWidget {
  const ChatRoomCreationPage({super.key});

  @override
  _ChatRoomCreationPageState createState() => _ChatRoomCreationPageState();
}

class _ChatRoomCreationPageState extends State<ChatRoomCreationPage> {
  String? chatRoomName;
  String? chatRoomDescription;

  Future<void> _selectImageFromDevice() async {
    // Implement image selection logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Chat Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _selectImageFromDevice();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: const Icon(Icons.upload_file, size: 50, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Set the name of the chat room:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  chatRoomName = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text('Set the description of the chat room:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  chatRoomDescription = value;
                });
              },
            ),
            const SizedBox(height: 32.0),
            Center(
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle create room button click
                    // You can access the chatRoomName and chatRoomDescription variables here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatRoomJoiningPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.transparent, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF53EAEB),
                          Color(0xFF016BB4),
                          Color(0xFF2D3A93),
                          Color(0xFF8139B8),
                          Color(0xFF783BB3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0712, 0.285, 0.4562, 0.7251, 0.9251],
                      ),
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Chat',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
