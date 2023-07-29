import 'package:flutter/material.dart';
import 'package:messagingapp/pages/login_page.dart';
import 'package:messagingapp/pages/register_page.dart';

class LoginOrRegistre extends StatefulWidget {
  const LoginOrRegistre({super.key});

  @override
  State<LoginOrRegistre> createState() => _LoginOrRegistreState();
}

class _LoginOrRegistreState extends State<LoginOrRegistre> {
  bool showloginpage=true;

  //toggle between pages
  void togglepages(){
    setState(() {
      showloginpage=!showloginpage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showloginpage){
      return LoginPage(onTap: togglepages);
    }
    else {
      return RegistrePage(onTap: togglepages);
    }
  }
}