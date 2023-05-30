import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendoo/message.dart';
import 'package:vendoo/newroom.dart';

class ChatRoomJoiningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Rooms'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/ventooV.png', // Assuming the logo file is in the assets folder
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Chat Room 1'),
                  subtitle: Text('Lorem ipsum dolor sit amet.'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessagingScreen(
                                chatRoomName: "Chat Room 1",
                              )),
                    );
                  },
                ),
                ListTile(
                  title: Text('Chat Room 2'),
                  subtitle: Text('Consectetur adipiscing elit.'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessagingScreen(
                                chatRoomName: "Chat Room 2",
                              )),
                    );
                  },
                ),
                // Add more chat rooms here
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatRoomCreationPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
