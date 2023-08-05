import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/components/chat_bubble.dart';
import 'package:messagingapp/components/my_textfield.dart';
import 'package:messagingapp/services/chat/chat_service.dart';

class Chatpage extends StatefulWidget {
  final String receiveruseremail;
  final String receiverid;
  const Chatpage(
      {super.key, required this.receiveruseremail, required this.receiverid});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final TextEditingController _messagecontroller = TextEditingController();
  final Chatservice _chatservice = Chatservice();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    //sending the message if the field is not empty
    if (_messagecontroller.text.isNotEmpty) {
      await _chatservice.sendMessage(
          widget.receiverid, _messagecontroller.text);
      //clear the controller
      setState(() {
        _messagecontroller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget.receiveruseremail),
      ),
      body: Column(children: [
        //messages
        Expanded(child: _buildMessageList()),
        //user input
        _buildMessageInput(),

        SizedBox(height: 25,)
      ]),
    );
  }

  //build message list
  Widget _buildMessageList(){
    return StreamBuilder(
      stream: _chatservice.getMessage(widget.receiverid, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError){
          return Text("error ${snapshot.error.toString()}");
        }
        if (snapshot.connectionState ==ConnectionState.waiting){
          return Text("Loading ...");
        }
        return ListView(
          children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        );
      },
      );
  }
  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    //align the messages
    var alignment = (data["senderId"] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
        return Container(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: (data["senderId"] == _firebaseAuth.currentUser!.uid) ?CrossAxisAlignment.end :CrossAxisAlignment.start,
              children: [
              Text(data["senderEmail"]),
              SizedBox(height: 5,),
              ChatBubble(message: data["message"])
            ],),
          ),
        );
  }
  //build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              child: MyTextfield(
            controller: _messagecontroller,
            hinttext: "enter your message",
            obscuretext: false,
            icon: null,
          )),
          IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.arrow_upward,
                size: 40,
              ))
        ],
      ),
    );
  }
}
