import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderemail;
  final String receiverid;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.receiverid,
    required this.senderemail,
    required this.senderId,
    required this.message,
    required this.timestamp,
  });

  //convert to map
  Map<String,dynamic> toMap(){
    return {
      'senderId':senderId,
      'senderEmail':senderemail,
      'receiverId':receiverid,
      'message' : message,
      'timeStamp':timestamp
    };
  }
}
