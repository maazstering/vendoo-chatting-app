import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendoo/api/apis.dart';
import 'package:vendoo/models/chat_user.dart';
//import 'package:vendoo/screens/messaging/ui/message.dart';
import 'package:vendoo/screens/newroom/ui/newroom.dart';
import 'package:vendoo/screens/account/ui/account.dart';
import '../../../widgets/chat_user_card.dart';
import '../../../models/chat_user.dart';

class ChatRoomJoiningPage extends StatefulWidget {
  ChatRoomJoiningPage({super.key});

  @override
  State<ChatRoomJoiningPage> createState() => _ChatRoomJoiningPageState();
}

class _ChatRoomJoiningPageState extends State<ChatRoomJoiningPage> {
  @override
  initState() {
    super.initState();
    APIs.getSelfInfo();
  }
  List<ChatUser> list = [];

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
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: APIs.getAllUsers(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      list = data
                              ?.map((e) => ChatUser.fromJson(e.data()))
                              .toList() ??
                          [];
                      if (list.isNotEmpty) {
                        return ListView.builder(
                            itemCount: list.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return chatUserCard(user: list[index]);
                            });
                      } else {
                        return const Center(
                            child: Text('No connections found!',
                                style: TextStyle(fontSize: 20)));
                      }
                  }
                }),
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
