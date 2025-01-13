import 'package:easycount/app/widgets/button.dart';
import 'package:easycount/app/widgets/inputform.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Regist extends StatelessWidget {
  Regist({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register',style: GoogleFonts.oswald(
          fontSize: 30,
        ),),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
            Text('Masukkan Email aktif untuk melakukan registrasi',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20
            ),
            ),
            SizedBox(height: 30,),

            // input area
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email',
                  style:GoogleFonts.plusJakartaSans(
                    fontSize: 18
                  ),
                  ),     
                  SizedBox(height: 10,),
                  InputEmail(emailController: emailController,),

                  SizedBox(height: 10,),

                  Text('Password',
                  style:GoogleFonts.plusJakartaSans(
                    fontSize: 18
                  ),
                  ),   
                  SizedBox(height: 10,),
                  InputPass(passwordController: passwordController,)
                ],
              ),
            ),
            SizedBox(height: 20,),
            ButtonWidget(
              data: 'Regist',
              // pages: Login(),
              color: Color.fromRGBO(89, 119, 181, 1),
              colortext: Colors.white,
              emailController: emailController,
              passwordController: passwordController
            ),
        
          ],
        ),
      ),
    );
  }
}