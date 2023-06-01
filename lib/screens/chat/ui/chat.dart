import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vendoo/api/apis.dart';
import 'package:vendoo/screens/messaging/ui/message.dart';
import 'package:vendoo/screens/newroom/ui/newroom.dart';
import 'package:vendoo/screens/account/ui/account.dart';
import '../../../widgets/chat_user_card.dart';

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
                stream: APIs.firestore
                    .collection('Users')
                    .snapshots(), // TODO: WORK TO BE DONE HERE
                builder: (context, snapshot) {
                  final list = [];
                  if (snapshot.hasData){
                    final data = snapshot.data?.docs;
                    for (var i in data!){
                      print(jsonEncode(i.data()));
                      list.add(i.data()['name']);
                    }
                  }
                  return ListView.builder(
                    itemCount: list.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                    //return const chatUserCard();
                    return Text('Name: ${list[index]} ');
                  });
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
