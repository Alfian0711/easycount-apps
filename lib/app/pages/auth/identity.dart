import 'package:easycount/app/controller/ProfileC.dart';
import 'package:easycount/app/theme/theme.dart';  
import 'package:flutter/material.dart';  
import 'package:google_fonts/google_fonts.dart';  
import 'package:intl_phone_field/intl_phone_field.dart';  

class Identity extends StatelessWidget {  
  Identity({super.key});  

  final TextEditingController namaPengguna = TextEditingController();  
  final TextEditingController namaUsaha = TextEditingController();  
  final TextEditingController phone = TextEditingController();  
  final TextEditingController alamat = TextEditingController();  
  final ocean = Color.fromRGBO(89, 119, 181, 1);  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: Text('Profile',  
          style: GoogleFonts.oswald(  
            fontSize: 30,  
          ),  
        ),  
      ),  
      body: Container(  
        margin: EdgeInsets.all(20),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            Text('Masukkan data profile usaha',  
              style: GoogleFonts.plusJakartaSans(  
                fontSize: 20  
              ),  
            ),  
            SizedBox(height: 50,),  
            Row(  
              children: [  
                Expanded(  
                  child: TextField(  
                    controller: namaPengguna,  
                    decoration: InputDecoration(  
                      labelText: 'Nama pengguna',  
                      filled: true,  
                      fillColor: Theme.of(context).brightness == DarkMode.brightness  
                      ? Color.fromRGBO(68, 68, 68, 1)  
                      : Colors.white,  
                      border: OutlineInputBorder(  
                        borderRadius: BorderRadius.circular(21),  
                      ),  
                      focusedBorder: OutlineInputBorder(  
                        borderRadius: BorderRadius.circular(21),  
                        borderSide: BorderSide(color: Colors.blue),  
                      ),  
                    ),  
                  ),  
                ),  
                SizedBox(width: 10),  
                Expanded(  
                  child: TextField(  
                    controller: namaUsaha,  
                    decoration: InputDecoration(  
                      labelText: 'Nama usaha',  
                      filled: true,  
                      fillColor: Theme.of(context).brightness == DarkMode.brightness  
                      ? Color.fromRGBO(68, 68, 68, 1)  
                      : Colors.white,  
                      border: OutlineInputBorder(  
                        borderRadius: BorderRadius.circular(21),  
                      ),  
                      focusedBorder: OutlineInputBorder(  
                        borderRadius: BorderRadius.circular(21),  
                        borderSide: BorderSide(color: Colors.blue),  
                      ),  
                    ),  
                  ),  
                ),  
              ],  
            ),  

            SizedBox(height: 30,),  

            IntlPhoneField(  
              controller: phone, 
              decoration: InputDecoration(  
                labelText: 'Nomor Handphone',  
                border: OutlineInputBorder(  
                  borderRadius: BorderRadius.circular(20),  
                  borderSide: BorderSide(),  
                ),  
              ),  
              initialCountryCode: 'IN',  
              onChanged: (phone) {  
                print(phone.completeNumber);   
              },  
            ),  

            SizedBox(height: 20,),  

            TextField(  
              controller: alamat,  
              decoration: InputDecoration(  
                hintText: 'Alamat Perusahaan',  
                labelText: 'Alamat',  
                filled: true,  
                fillColor: Theme.of(context).brightness == DarkMode.brightness  
                    ? Color.fromRGBO(68, 68, 68, 1)  
                    : Colors.white,  
                border: OutlineInputBorder(  
                  borderRadius: BorderRadius.circular(21),  
                ),  
                focusedBorder: OutlineInputBorder(  
                  borderRadius: BorderRadius.circular(21),  
                  borderSide: BorderSide(color: Colors.blue),  
                ),  
              ),  
            ),  

            SizedBox(height: 30,),  

            ElevatedButton(  
              style: ElevatedButton.styleFrom(  
                fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),  
                backgroundColor: Colors.white,  
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),  
              ),  

              onPressed: () {  
                if (namaPengguna.text.isEmpty ||  
                      alamat.text.isEmpty ||  
                      namaUsaha.text.isEmpty ||  
                      phone.toString().isEmpty) {  
                    ScaffoldMessenger.of(context).showSnackBar(  
                      SnackBar(  
                        content: Text('Mohon isi semua input yang diperlukan'),  
                      ),  
                    );  
                    return;  
                  } 
                ProfileC().AddPengguna(
                  nama: namaPengguna.text,
                  alamat:alamat.text,
                  status: 'pemilik',
                  namaUsaha: namaUsaha.text,
                  phone: phone.text,
                  context: context);
                  
                  alamat.clear();
                  namaPengguna.clear();
                  namaUsaha.clear();
                  phone.clear(); 
              },  
              child: Text('Simpan',   
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