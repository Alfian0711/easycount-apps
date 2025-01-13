import 'package:easycount/app/pages/auth/loginview.dart';
import 'package:easycount/app/pages/auth/registview.dart';
import 'package:easycount/app/theme/theme.dart';
import 'package:easycount/app/widgets/textIntro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});
  
  @override
  Widget build(BuildContext context) {
  final ocean = Color.fromRGBO(89, 119, 181, 1);

    return Scaffold(
      appBar: AppBar(
        leading: 
        Padding(padding: EdgeInsets.only(left:20),
        child:
        Image(image: AssetImage('assets/logo/logoapp.png')),
        )
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: 'Easy',
                  style: GoogleFonts.oswald(
                    fontSize: 50,
                    color: Theme.of(context).brightness== DarkMode.brightness
                    ? Colors.white
                    : Colors.black
                  ),
                  children: [
                    TextSpan(
                      text: 'Count',
                      style: GoogleFonts.oswald(
                          fontSize: 50, color: Color.fromRGBO(89, 119, 181, 1)),
                    )
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Manajemen Keuangan UMK',
              style: GoogleFonts.oswald(
                fontSize: 25,
              ),
            ),
            SizedBox(height: 20,),
           Container(
            child: Introtext(),
           ),
        
            // Center(child: ToggleTheme()),

            SizedBox(height: 30,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
              backgroundColor: ocean,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Text('Login', 
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20
                ),
              ),
            ),
            SizedBox(height: 10,),
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),

              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Regist()),
                );
              },
              child: Text('Regist', 
              style: GoogleFonts.poppins(
                color: ocean,
                fontWeight: FontWeight.bold,
                fontSize: 20
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
