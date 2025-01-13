import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';

class TermPrivasy extends StatelessWidget {
  const TermPrivasy({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    // Terms and Privacy
      RichText(
      text: TextSpan(
        text: 'By signing up, you agree to our ',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          color: Theme.of(context).brightness== DarkMode.brightness
                    ? Colors.white
                    : Colors.black,
        ),
        children: [
          TextSpan(
            text: ' Terms of Service\n',
            style: TextStyle(color: Theme.of(context).brightness== DarkMode.brightness
                    ? Color.fromRGBO(89, 119, 181, 1)
                    : Color.fromRGBO(89, 119, 181, 1)),
          ),
          TextSpan(
            text: 'and ',
          ),
          TextSpan(
            text: ' Privacy Policy',
            style: TextStyle(color: Theme.of(context).brightness== DarkMode.brightness
                    ? Color.fromRGBO(89, 119, 181, 1)
                    : Color.fromRGBO(89, 119, 181, 1)),
          ),
        ],
      ),
    );
  }
}
