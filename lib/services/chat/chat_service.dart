import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/models/message.dart';

class Chatservice extends ChangeNotifier {
  //get instance of auth and firestore
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //send message
  Future<void> sendMessage(String receiverid, String message) async {
    //get current user info
    final String currentUserId = _firebaseauth.currentUser!.uid;
    final String currentUseremail = _firebaseauth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    Message newMessage = Message(
        receiverid: receiverid,
        senderemail: currentUseremail,
        senderId: currentUserId,
        message: message,
        timestamp: timestamp);
    //construct chat room id from current user id and receiver id
    List<String> ids = [currentUserId, receiverid];
    ids.sort(); //sort the ids  ( this ensures that chat room ids will always be the same for any pair)
    String chatroomId =
        ids.join("_"); //combine the ids inro a string to use as a chatroom id
    //add new message to db
    await _firestore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    //construct chat room id from user ids ( sorted to ensure it matches the id used when sending messages)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
