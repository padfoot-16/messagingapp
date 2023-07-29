import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegistrePage extends StatefulWidget {
  final void Function()? onTap;
  const RegistrePage({super.key,required this.onTap});

  @override
  State<RegistrePage> createState() => _RegistrePageState();
}

class _RegistrePageState extends State<RegistrePage> {

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  void signUp(){

  }
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
                "Let's create an account for you!",
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
              //confirm password textfield
              MyTextfield(
                  controller: confirmpasswordcontroller,
                  hinttext: "Confirm your password",
                  obscuretext: true),

              SizedBox(
                height: 25,
              ),
              //sign in button
              MyButton(
              onTap: signUp,
               text: "Sign Up"),

               SizedBox(height: 50,),
              //register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text("Already a member ?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Login",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[800]),),
                  )
                ])
            ]),
          ),
        ),
      ),
    );
  }
}
