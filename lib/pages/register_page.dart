import 'package:flutter/material.dart';
import 'package:messagingapp/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegistrePage extends StatefulWidget {
  final void Function()? onTap;
  const RegistrePage({super.key, required this.onTap});

  @override
  State<RegistrePage> createState() => _RegistrePageState();
}

class _RegistrePageState extends State<RegistrePage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  void signUp() async {
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
            content: Text("Passwords don't match")));
      return;    
    }
    final authSerice= Provider.of<AuthService>(context,listen: false);
    try {
      await authSerice.signupwithemailandpassword(emailcontroller.text, passwordcontroller.text);
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
                      "Let's create an account for you!",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //email textfield
                    MyTextfield(
                        controller: emailcontroller,
                        icon: Icon(Icons.person),
                        hinttext: "put your email here ",
                        obscuretext: false),

                    const SizedBox(
                      height: 15,
                    ),
                    //password textfield
                    MyTextfield(
                        controller: passwordcontroller,
                        icon: Icon(Icons.lock),
                        hinttext: "Put your password here",
                        obscuretext: true),

                    const SizedBox(
                      height: 25,
                    ),
                    //confirm password textfield
                    MyTextfield(
                        controller: confirmpasswordcontroller,
                        icon: Icon(Icons.lock),
                        hinttext: "Confirm your password",
                        obscuretext: true),

                    const SizedBox(
                      height: 25,
                    ),
                    //sign in button
                    MyButton(onTap: signUp, text: "Sign Up",color: Colors.black,),

                    const SizedBox(
                      height: 50,
                    ),
                    //register
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Already a member ?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple[800]),
                        ),
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
