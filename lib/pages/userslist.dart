import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chatpage.dart';
class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_buildUserList() ,
    );
  }
  // build a list of users excepet for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          children: 
            snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
        );
      },
    );
  }

  //build user list item

  Widget _buildUserListItem(DocumentSnapshot document){
    Map<String,dynamic>data=document.data()! as Map<String,dynamic>;

    if(_auth.currentUser!.email != data["email"]){
      return ListTile(
        title: Text(data["email"]),
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => Chatpage(receiveruseremail: data["email"],receiverid: data["uid"],),));
        },
      );
    }
    else {
      return Container();
    }
  }
}