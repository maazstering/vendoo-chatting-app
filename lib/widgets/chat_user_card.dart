import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return  Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.5,
        child: InkWell(
          onTap: (){},
            child:  ListTile(
      leading: CircleAvatar(child: Icon(CupertinoIcons.person)),
      title: Text(widget.user.name),
      subtitle: Text(widget.user.about, maxLines: 1),
      trailing: Text('12:00 PM', style: TextStyle(color: Colors.black54),),
    )));
  }
}