import 'package:easycount/app/widgets/button.dart';
import 'package:easycount/app/widgets/inputform.dart';
import 'package:easycount/app/widgets/term.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: GoogleFonts.oswald(
            fontSize: screenWidth * 0.08, 
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Masukkan akun yang telah didaftarkan',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: screenWidth * 0.05, 
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Input area
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: screenWidth * 0.045,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    InputEmail(emailController: emailController),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'Password',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    InputPass(passwordController: passwordController),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Button
              ButtonWidget(
                data: 'Login',
                color: const Color.fromRGBO(89, 119, 181, 1),
                colortext: Colors.white,
                emailController: emailController,
                passwordController: passwordController,
              ),
              SizedBox(height: screenHeight * 0.01),

              // Option
              TextButton(
                onPressed: () {},
                child: Text(
                  'Lupa Password?',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(89, 119, 181, 1),
                  ),
                ),
              ),

              // Terms and Privacy
              Container(
                margin: EdgeInsets.only(left: screenWidth * 0.03),
                child: TermPrivasy(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
