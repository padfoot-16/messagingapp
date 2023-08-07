import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:messagingapp/pages/people.dart';
import 'package:messagingapp/pages/profile_page.dart';
import 'package:messagingapp/pages/userslist.dart';
import 'package:messagingapp/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MessageList(),
    UsersList(),
    ProfilePage(),
  ];
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
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        color: Colors.deepPurple[100],
        child: SafeArea(
            child: GNav(
              activeColor: Colors.deepPurple,
              gap: 8,
              tabs: [
          GButton(
            icon: Icons.message,
            text: "Messages",
          ),
          GButton(
            icon: Icons.list,
            text: "Users",
          ),
          GButton(
            icon: Icons.person,
            text: "Profile",
          )
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        )),
      ),
    );
  }
}
