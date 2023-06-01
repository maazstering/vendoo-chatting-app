import 'package:flutter/material.dart';
import 'package:vendoo/screens/messaging/ui/message.dart';
import 'package:vendoo/screens/newroom/ui/newroom.dart';
import 'package:vendoo/screens/account/ui/account.dart';

class ChatRoomJoiningPage extends StatelessWidget {
  const ChatRoomJoiningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Chat Rooms'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle),
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
                  title: const Text('Chat Room 1'),
                  subtitle: const Text('Lorem ipsum dolor sit amet.'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MessagingScreen(
                                chatRoomName: "Chat Room 1",
                              )),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Chat Room 2'),
                  subtitle: const Text('Consectetur adipiscing elit.'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MessagingScreen(
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
            MaterialPageRoute(
                builder: (context) => const ChatRoomCreationPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
