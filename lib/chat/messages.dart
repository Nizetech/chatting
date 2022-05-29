import 'package:chatting/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  //const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdOn',
            //'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (!chatSnapshot.hasData) {
          return Center(
            child: const CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index]['text'],
            chatDocs[index]['userId'] == FirebaseAuth.instance.currentUser.uid,
            chatDocs[index]['username'],
            chatDocs[index]['userImage'],
            chatDocs[index]['createdOn'],

            key: ValueKey(chatDocs[index].id),
            //ValueKey(chatDocs[index].documents),
          ),
        );
      },
    );
  }
}
