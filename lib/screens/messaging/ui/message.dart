import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/apis.dart';
import '../../../models/chat_user.dart';
import '../../../models/messages.dart';
import '../../../widgets/message_card.dart';
import '../../account/ui/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  final ChatUser user;

  Messages({required this.user});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: APIs.getAllMessages(user),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<Message> messages = snapshot.data!.docs
                .map((doc) =>
                    Message.fromJson(doc.data() as Map<String, dynamic>))
                .toList();
            messages = messages
                .where((message) =>
                    (message.fromId == APIs.cuser && message.toId == user.id) ||
                    (message.fromId == user.id && message.toId == APIs.cuser))
                .toList();
            return ListView.builder(
              reverse: true,
              itemCount: messages.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return MessageCard(
                    message: messages[
                        index]); // replace with actual MessageCard widget
              },
            );
          } else {
            return const Center(
              child: Text('Say Hi! 👋', style: TextStyle(fontSize: 20)),
            );
          }
        },
      ),
    );
  }
}

class MessagingScreen extends StatefulWidget {
  final ChatUser user;

  const MessagingScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  List<Message> _list = [];
  final _textController = TextEditingController();
  bool _showEmoji = false, _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: _appBar(),
          ),
          backgroundColor: Color.fromARGB(255, 226, 209, 240),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: APIs.getAllMessages(widget.user),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      //if data is loading
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const SizedBox();

                      //if some or all data is loaded then show it
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        _list = data
                                ?.map((e) => Message.fromJson(e.data()))
                                .toList() ??
                            [];

                        if (_list.isNotEmpty) {
                          return ListView.builder(
                              reverse: true,
                              itemCount: _list.length,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return MessageCard(message: _list[index]);
                              });
                        } else {
                          return const Center(
                            child: Text('Say Hi! 👋',
                                style: TextStyle(fontSize: 20)),
                          );
                        }
                      default:
                        return const SizedBox();
                    }
                  },
                ),
              ),
              _buildChatControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            // backgroundImage: Icon(Icons.account_circle),
          ),
          SizedBox(width: 10),
          Text(widget.user.name),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AccountPage(user: widget.user),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChatControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.insert_emoticon),
            onPressed: () {
              setState(() {
                _showEmoji = !_showEmoji;
              });
            },
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () async {
              await _pickImageFromGallery();
            },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              await _sendMessage();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        _isUploading = true;
      });

      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    _textController.clear();

    // await APIs.sendMessage(
    //   Message(
    //     fromId: APIs.cuser,
    //     toId: widget.user.id,
    //     text: text,
    //   ),
    // );
  }
}
