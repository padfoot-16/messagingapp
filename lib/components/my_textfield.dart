import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
final TextEditingController controller;
final String hinttext;
final bool obscuretext;

  const MyTextfield({super.key,
  required this.controller,
  required this.hinttext,
  required this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscuretext,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple.shade100),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.deepPurple[200],
        filled: true,
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colors.white)
      ),

    );
  }
}