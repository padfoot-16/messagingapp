import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagingapp/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

import 'chatpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Homepage"),
        actions: [
          //sign out button
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: _buildUserList(),
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
