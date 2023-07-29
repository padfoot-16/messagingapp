import 'package:flutter/material.dart';
import 'package:messagingapp/components/my_button.dart';
import 'package:messagingapp/components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //logo
              Container(
                height: 200,
                child: Image.asset("assets/pulse.png"),
              ),
              SizedBox(
                height: 20,
              ),
              //welcome back message
              Text(
                "Welcome back you've been missed!",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),

              //email textfield
              MyTextfield(
                  controller: emailcontroller,
                  hinttext: "put your email here ",
                  obscuretext: false),

              SizedBox(
                height: 15,
              ),
              //password textfield
              MyTextfield(
                  controller: passwordcontroller,
                  hinttext: "Put your password here",
                  obscuretext: true),

              SizedBox(
                height: 25,
              ),
              //sign in button
              MyButton(
              onTap: () {},
               text: "Sign In"),

               SizedBox(height: 50,),
              //register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text("Not a member ?"),
                  SizedBox(width: 5,),
                  Text("Register Now",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple[800]),)
                ])
            ]),
          ),
        ),
      ),
    );
  }
}
