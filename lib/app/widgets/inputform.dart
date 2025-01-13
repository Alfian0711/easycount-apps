import 'package:flutter/material.dart';

class InputEmail extends StatelessWidget {

  final TextEditingController emailController;

  InputEmail({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return TextField(
    controller: emailController ,
    decoration: InputDecoration(
    hintText: 'Enter your Email',
    hintStyle: TextStyle(
      color: Colors.black,
    ),
    filled: true,
    fillColor: Colors.grey[200],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(21),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(21),
      borderSide: BorderSide(color: Colors.blue),
    ),
  ),
  style: TextStyle(color: Colors.black),
  );
  }
}

class InputPass extends StatelessWidget {
  final TextEditingController passwordController;

  const InputPass({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return TextField(
    controller: passwordController,
      obscureText: true,
  decoration: InputDecoration(
    hintText: 'Enter your Pass',
    hintStyle: TextStyle(
      color:  Colors.black
    ),
    filled: true,
    fillColor: Colors.grey[200],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(21),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(21),
      borderSide: BorderSide(color: Colors.blue),
    ),
  ),
  style: TextStyle(color: Colors.black),
);
  }
}