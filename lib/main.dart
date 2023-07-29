import 'package:flutter/material.dart';
import 'package:messagingapp/pages/login_page.dart';
import 'package:messagingapp/pages/register_page.dart';
import 'package:messagingapp/services/auth/login_or_registre.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Messaging App",
      home: LoginOrRegistre(),
    );
  }
}
