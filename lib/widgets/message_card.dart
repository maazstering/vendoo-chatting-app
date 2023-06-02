import 'dart:js';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../api/apis.dart';
import '../models/messages.dart';

// for showing single message details
class MessageCard extends StatelessWidget {
  const MessageCard({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    bool isMe = APIs.user.uid == message.fromId;
    return InkWell(
      onLongPress: () {
        _showBottomSheet(context, isMe);
      },
      child: isMe ? _greenMessage() : _blueMessage(),
    );
  }

  // sender or another user message
  Widget _blueMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(message.type as double),
            margin: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(context as BuildContext).size.width * .04,
              vertical:
                  MediaQuery.of(context as BuildContext).size.height * .01,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 221, 245, 255),
              border: Border.all(color: Colors.lightBlue),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: message.type == Type.text
                ? Text(
                    message.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: message.msg,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),

        //message time
        Padding(
          padding: EdgeInsets.only(
            right: MediaQuery.of(context as BuildContext).size.width * .04,
          ),
          child: Text(
            message.sent
                .toString(), // Replace with the appropriate property for message time
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  // our or user message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message time
        Row(
          children: [
            //for adding some space
            SizedBox(width: 2),

            //double tick blue icon for message read
            if (message.read.isNotEmpty)
              const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),

            //for adding some space
            const SizedBox(width: 2),

            //sent time
            Text(
              message.sent
                  .toString(), // Replace with the appropriate property for message time
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),

        //message content
        Flexible(
          child: Container(
            padding: EdgeInsets.all(message.type == Type.image
                ? MediaQuery.of(context as BuildContext).size.width * .03
                : MediaQuery.of(context as BuildContext).size.width * .04),
            margin: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(context as BuildContext).size.width * .04,
              vertical:
                  MediaQuery.of(context as BuildContext).size.height * .01,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 218, 255, 176),
              border: Border.all(color: Colors.lightGreen),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: message.type == Type.text
                ? Text(
                    message.msg,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: message.msg,
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image, size: 70),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  // bottom sheet for modifying message details
  void _showBottomSheet(BuildContext context, bool isMe) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children: [
            //black divider
            Container(
              height: 4,
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * .015,
                horizontal: MediaQuery.of(context).size.width * .4,
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            message.type == Type.text
                ? _OptionItem(
                    icon: const Icon(Icons.copy_all_rounded,
                        color: Colors.blue, size: 26),
                    name: 'Copy Text',
                    onTap: () async {
                      await Clipboard.setData(
                        ClipboardData(text: message.msg),
                      );
                      Navigator.pop(context);
                    },
                  )
                : _OptionItem(
                    icon: const Icon(Icons.download_rounded,
                        color: Colors.blue, size: 26),
                    name: 'Save Image',
                    onTap: () {
                      // Handle saving the image
                      Navigator.pop(context);
                    },
                  ),

            Divider(
              color: Colors.black54,
              endIndent: MediaQuery.of(context).size.width * .04,
              indent: MediaQuery.of(context).size.width * .04,
            ),

            if (message.type == Type.text && isMe)
              _OptionItem(
                icon: const Icon(Icons.edit, color: Colors.blue, size: 26),
                name: 'Edit Message',
                onTap: () {
                  // Handle editing the message
                  Navigator.pop(context);
                },
              ),

            if (isMe)
              _OptionItem(
                icon: const Icon(Icons.delete_forever,
                    color: Colors.red, size: 26),
                name: 'Delete Message',
                onTap: () {
                  // Handle deleting the message
                  Navigator.pop(context);
                },
              ),

            Divider(
              color: Colors.black54,
              endIndent: MediaQuery.of(context).size.width * .04,
              indent: MediaQuery.of(context).size.width * .04,
            ),

            _OptionItem(
              icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
              name:
                  'Sent At: ${message.sent.toString()}', // Replace with the appropriate property for message time
              onTap: () {},
            ),

            _OptionItem(
              icon: const Icon(Icons.remove_red_eye, color: Colors.green),
              name: message.read.isEmpty
                  ? 'Read At: Not seen yet'
                  : 'Read At: ${message.read.toString()}', // Replace with the appropriate property for message time
              onTap: () {},
            ),

            SizedBox(height: MediaQuery.of(context).size.height * .015),
          ],
        );
      },
    );
  }
}

// item in the bottom sheet
class _OptionItem extends StatelessWidget {
  const _OptionItem(
      {Key? key, required this.icon, required this.name, required this.onTap})
      : super(key: key);

  final Icon icon;
  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(name),
      onTap: onTap,
    );
  }
}
