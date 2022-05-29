import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMesages extends StatefulWidget {
  NewMesages({Key key}) : super(key: key);

  @override
  State<NewMesages> createState() => _NewMesagesState();
}

class _NewMesagesState extends State<NewMesages> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  Future<void> _sendMessage() async {
    try {
      FocusScope.of(context).unfocus();
      final user = FirebaseAuth.instance.currentUser;
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      FirebaseFirestore.instance.collection('chat').add({
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'createdOn': FieldValue.serverTimestamp(),
        'userId': user.uid,
        'username': userData['username'],
        'userImage': userData['image_url']
      });
      _controller.clear();
    } catch (error) {
      // var message = 'An error occured, please click send!';
      // if (error.message != null) {
      //   message = error.message;
      // }
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(
                labelText: 'Send a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                  print(value);
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
