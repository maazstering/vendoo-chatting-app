import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vendoo/screens/messaging/ui/message.dart';
import '../api/apis.dart';
import '../models/chat_user.dart';

class chatUserCard extends StatefulWidget {
  final ChatUser user;

  const chatUserCard({super.key, required this.user});

  @override
  State<chatUserCard> createState() => _chatUserCardState();
}

class _chatUserCardState extends State<chatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0.5,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MessagingScreen(
                            user: APIs.me,
                          )));
            },
            child: ListTile(
              leading: CachedNetworkImage(
                  imageUrl: widget.user.image,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person))),
              //CircleAvatar(child: Icon(CupertinoIcons.person)),
              title: Text(widget.user.name),
              subtitle: Text(widget.user.about, maxLines: 1),
              trailing: Text(
                '12:00 PM',
                style: TextStyle(color: Colors.black54),
              ),
            )));
  }
}
