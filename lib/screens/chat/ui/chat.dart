import 'package:flutter/material.dart';
import 'package:vendoo/screens/messaging/ui/message.dart';
import 'package:vendoo/screens/newroom/ui/newroom.dart';

class ChatRoomJoiningPage extends StatelessWidget {
  const ChatRoomJoiningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Text('Chat Rooms'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/ventooV.png', // Assuming the logo file is in the assets folder
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
            MaterialPageRoute(builder: (context) => const ChatRoomCreationPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
