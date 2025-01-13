// import 'package:cloud_firestore/cloud_firestore.dart';  
import 'package:easycount/app/models/penggunaM.dart';  
import 'package:flutter/material.dart';  
import 'package:google_fonts/google_fonts.dart';  

import '../controller/AuthC.dart';  
import '../controller/ProfileC.dart';
import '../widgets/bottomBar.dart';
import '../widgets/toggletheme.dart';  

class Setting extends StatelessWidget {  
  const Setting({super.key});  

  @override  
  Widget build(BuildContext context) {  
    final ocean = Color.fromRGBO(89, 119, 181, 1);  
    final profileController = ProfileC();  

    return Scaffold(  
      appBar: AppBar(  
        title: Text('Setting', style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        ),),  
      ),
      body: Column(  
        mainAxisAlignment: MainAxisAlignment.center,  
        children: [  
          // Bagian Daftar Pengguna  
          Expanded(  
            child: StreamBuilder<List<PenggunaM>>(  
              stream: profileController.Tampilpengguna(),  
              builder: (context, snapshot) {  
                if (snapshot.hasError) {  
                  return Center(child: Text('Something went wrong: ${snapshot.error}'));  
                }  
                if (snapshot.connectionState == ConnectionState.waiting) {  
                  return Center(child: CircularProgressIndicator());  
                }  

                final users = snapshot.data ?? [];  

                if (users.isEmpty) {  
                  return Center(child: Text('No users found.'));  
                }  

                return Column(  
                  children: [  
                    Container(  
                      margin: EdgeInsets.all(16.0),  
                      child: Row(  
                        children: [  
                          CircleAvatar(  
                            backgroundImage: AssetImage('assets/logo/logo.png'),  
                            radius: 30,  
                          ),  
                          SizedBox(width: 20),  
                          Column(  
                            crossAxisAlignment: CrossAxisAlignment.start,  
                            children: [  
                              Text(  
                                users.first.company, // Ganti dengan data sebenarnya  
                                style: TextStyle(fontWeight: FontWeight.bold),  
                              ),  
                              Text(users.first.address), // Ganti dengan data sebenarnya  
                            ],  
                          ),  
                        ],  
                      ),  
                    ),  
                    SizedBox(height: 20,),
                    Expanded(  
                      child: ListView.builder(  
                        itemCount: users.length,  
                        itemBuilder: (context, index) {  
                          final user = users[index];  
                          return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(42, 42, 42, 1)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Email'),
                                      Text(user.email),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                 Container(
                                  padding: EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(42, 42, 42, 1)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('No Hp'),
                                      Text(user.phone),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                 Container(
                                  padding: EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(42, 42, 42, 1)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Usaha'),
                                      Text(user.company),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                 Container(
                                  padding: EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(42, 42, 42, 1)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Alamat'),
                                      Text(user.address),
                                    ],
                                  ),
                                ),
                              ],
                            );
                        },  
                      ),  
                    ),  
                  ],  
                );  
              },  
            ),  
          ),  

          Padding(  
            padding: EdgeInsets.only(top: 16,left: 16,right: 16),  
            child: ElevatedButton(  
              style: ElevatedButton.styleFrom(  
                fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),  
                backgroundColor: Theme.of(context).brightness == Brightness.dark  
                        ? ocean
                        : Colors.black,  
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),  
              ),  
              onPressed: () {  
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => theme()));
              },  
              child: Text(  
                'Ubah Tema',  
                style: GoogleFonts.poppins(  
                  color: Theme.of(context).brightness == Brightness.dark  
                        ? Colors.white  
                        : Colors.grey[200],    
                  fontWeight: FontWeight.bold,  
                  fontSize: 20,  
                ),  
              ),  
            ),  
          ),  
          

          // Tombol Logout  
          Padding(  
            padding:  EdgeInsets.all(16.0),  
            child: ElevatedButton(  
              style: ElevatedButton.styleFrom(  
                fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),  
                backgroundColor: Colors.red,  
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),  
              ),  
              onPressed: () {  
                AuthC().Logout(context);  
              },  
              child: Text(  
                'Logout',  
                style: GoogleFonts.poppins(  
                  color: Colors.white,  
                  fontWeight: FontWeight.bold,  
                  fontSize: 20,  
                ),  
              ),  
            ),  
          ),  
        ],  
      ),  
    );  
  }  
}

class theme extends StatelessWidget {
  const theme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme'),
        leading: IconButton(  
          onPressed: () {  
            Navigator.pushReplacement(  
              context,  
              MaterialPageRoute(  
                builder: (context) => Bottombar(initialIndex: 0)  
              )  
            );  
          },  
          icon: Icon(Icons.arrow_back_ios)  
        )  
      ),
      body: Column(
        children: [
          Center(
            child: ToggleTheme(),
          ),
        ],
      ),
    );
  }
}