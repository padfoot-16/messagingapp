import 'package:flutter/material.dart';
import 'package:messagingapp/components/my_button.dart';
import 'package:messagingapp/components/my_textfield.dart';
import 'package:messagingapp/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()?onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void signIn()async{
    final authService=Provider.of<AuthService>(context,listen: false);

    try {
      await authService.signinwithemailandpassword(
        emailcontroller.text,
         passwordcontroller.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                //logo
                SizedBox(
                  height: 200,
                  child: Image.asset("assets/pulse.png"),
                ),
                const SizedBox(
                  height: 20,
                ),
                //welcome back message
                const Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
      
                //email textfield
                MyTextfield(
                    controller: emailcontroller,
                    hinttext: "put your email here ",
                    obscuretext: false),
      
                const SizedBox(
                  height: 15,
                ),
                //password textfield
                MyTextfield(
                    controller: passwordcontroller,
                    hinttext: "Put your password here",
                    obscuretext: true),
      
                const SizedBox(
                  height: 25,
                ),
                //sign in button
                MyButton(
                onTap: signIn,
                 text: "Sign In"),
      
                 const SizedBox(height: 50,),
                //register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    const Text("Not a member ?"),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Register Now",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[800]),),
                    )
                  ])
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
