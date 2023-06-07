import 'dart:developer';
import 'dart:io' show File, Platform;

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendoo/models/chat_user.dart';
import 'package:vendoo/widgets/message_card.dart';

import '../../../api/apis.dart';
import '../../../models/message.dart';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';

import '../bloc/message_bloc.dart';

class MessageScreen extends StatefulWidget {
  final ChatUser user;
  const MessageScreen({super.key, required this.user});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // for storing all messages
  List<Message> _list = [];
  //for handling message text changes
  final _textController = TextEditingController();

  // to check whether to show emojis or not
  bool _showEmoji = false;

  final MessageBloc _messageBloc = MessageBloc();
//  return BlocProvider<LoginBloc>.value(
//       value: loginBloc,
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageBloc(),
      child: BlocConsumer<MessageBloc, MessageState>(
        listener: (context, state) {
          if (state is MessageErrorState) {
            // Show a snackbar or display an error message when an error occurs
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
              ),
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: _appBar(),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                          stream: APIs.getAllMessages(widget.user),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                              case ConnectionState.none:
                                return const Center(child: const SizedBox());
                              case ConnectionState.active:
                              case ConnectionState.done:
                                final data = snapshot.data?.docs;
                                _list = data
                                        ?.map((e) => Message.fromJson(e.data()))
                                        .toList() ??
                                    [];

                                if (_list.isNotEmpty) {
                                  return ListView.builder(
                                      itemCount: _list.length,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return MessageCard(
                                          message: _list[index],
                                        );
                                      });
                                } else {
                                  return const Center(
                                      child: Text('Say Hi!👋',
                                          style: TextStyle(fontSize: 20)));
                                }
                            }
                          }),
                    ),
                    _chatInput(),
                    if (_showEmoji)
                      SizedBox(
                        height: 250,
                        child: EmojiPicker(
                          textEditingController: _textController,
                          config: const Config(
                            columns: 8,
                            emojiSizeMax: 32,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: () {},
      child: Row(children: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black54,
            )),
        //image needs to be fixed
        CircleAvatar(
          child: Image.asset('assets/images/userIcon.jpg'),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.user.name,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            )
          ],
        )
      ]),
    );
  }

  Widget _chatInput() {
    bool _showEmoji = false, _isUploading = false;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  //emoji button
                  IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        setState(() => _showEmoji = !_showEmoji);
                        //add on pressed here
                      },
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Color.fromARGB(255, 135, 13, 156),
                        size: 26,
                      )),

                  //text field
                  Expanded(
                      child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onTap: () {
                      if (_showEmoji) setState(() => _showEmoji = !_showEmoji);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Type Something...',
                      hintStyle: TextStyle(color: Colors.purpleAccent),
                      border: InputBorder.none,
                    ),
                  )),

                  //image from device
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Picking multiple images
                        final List<XFile> images =
                            await picker.pickMultiImage(imageQuality: 70);

                        // uploading & sending image one by one
                        for (var i in images) {
                          log('Image Path: ${i.path}');
                          setState(() => _isUploading = true);
                          await APIs.sendChatImage(widget.user, File(i.path));
                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Color.fromARGB(255, 135, 13, 156),
                        size: 26,
                      )),

                  // image from camera
                  IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();

                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 70);
                        if (image != null) {
                          log('Image Path: ${image.path}');
                          setState(() => _isUploading = true);

                          await APIs.sendChatImage(
                              widget.user, File(image.path));
                          setState(() => _isUploading = false);
                        }
                      },
                      icon: const Icon(
                        Icons.camera_alt_rounded,
                        color: Color.fromARGB(255, 135, 13, 156),
                        size: 26,
                      )),
                  const SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),

          //send message button
          MaterialButton(
            onPressed: () {
              _messageBloc.add(
                SendMessageEvent(
                  type: Type.Text,
                  message: _textController.text,
                  user: widget.user,
                ),
              );
              // if (_textController.text.isNotEmpty) {
              //   APIs.sendMessage(widget.user, _textController.text, Type.Text);
              //   _textController.text = '';
              // }
            },
            minWidth: 0,
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
            shape: const CircleBorder(),
            color: Colors.purple,
            child: const Icon(
              Icons.send,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    );
  }
}
