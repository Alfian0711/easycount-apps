import 'package:easycount/app/controller/TransaksiC.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmDialog extends StatelessWidget {
  final Map<String, dynamic> data;
  const ConfirmDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(  
          title: Text('Yakin Untuk Menghapus Data Ini?',
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          ),),  
          actions: [  
            ElevatedButton(  
              style: ElevatedButton.styleFrom(  
                    fixedSize: Size(120, 50),  
                    backgroundColor: Color.fromRGBO(89, 119, 181, 1), 
                    shape: RoundedRectangleBorder(  
                      borderRadius: BorderRadius.circular(10),  
                    ),  
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),  
                  ), 
              onPressed: () => Navigator.of(context).pop(false),  
              child: Text('Kembali',
              style: GoogleFonts.poppins(  
                      color: Colors.white,  
                      fontWeight: FontWeight.bold,  
                      fontSize: 18,  
                    ),  ),  
            ),  
            ElevatedButton( 
              style: ElevatedButton.styleFrom(  
                fixedSize: Size(120, 50),  
                backgroundColor: Colors.red, 
                shape: RoundedRectangleBorder(  
                  borderRadius: BorderRadius.circular(10),  
                ),  
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),  
              ),   
              onPressed: () => TransaksiC().Aksi_hapus(context: context, documentId:data['id']),  
              child: Text('Hapus',
                style: GoogleFonts.poppins(  
                  color: Colors.white,  
                  fontWeight: FontWeight.bold,  
                  fontSize: 18,  
                ), 
              ),  
            ),  
          ],  
        );
  }
}