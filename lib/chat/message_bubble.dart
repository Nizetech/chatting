import 'package:timeago/timeago.dart' as timeago;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  //const MessageBubble({Key key}) : super(key: key);
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  final Timestamp createdOn;
  final Key key;

  MessageBubble(
    this.message,
    this.isMe,
    this.userName,
    this.userImage,
    this.createdOn, {
    this.key,
  });

  //print(timeago.format(fifteenAgo));
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline1
                                .color),
                  ),
                  // Text(
                  //   createdOn.toDate().hour.toString() +
                  //       ':' +
                  //       createdOn.toDate().minute.toString(),
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   textAlign: isMe ? TextAlign.end : TextAlign.start,
                  // ),
                  Text(timeago.format(createdOn.toDate())),
                ],
              ),
            ),
            Positioned(
              top: -8,
              left: isMe ? null : 160,
              right: isMe ? 160 : null,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  userImage,
                ),
              ),
            ),
          ],
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
