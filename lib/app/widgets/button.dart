import 'package:easycount/app/controller/AuthC.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String data;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Color color, colortext;

  // void dispose() {  
  //   emailController.dispose();  
  //   passwordController.dispose();  
  // }


  const ButtonWidget({super.key, required this.data, required this.color, required this.colortext, required this.emailController, required this.passwordController});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      onPressed: () {
        if(data == 'Regist'){
        AuthC().Signup(
          email: emailController.text, 
          password: passwordController.text, 
          context: context);
        }
        else{
           AuthC().Signin(
          email: emailController.text, 
          password: passwordController.text, 
          context: context);
        }
        emailController.clear();
        passwordController.clear();
      },
      child: Text(data, 
      style: GoogleFonts.poppins(
        color: colortext,
        fontWeight: FontWeight.bold,
        fontSize: 20
        ),
      ),
    );
  }
}
