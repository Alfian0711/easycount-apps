import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easycount/app/controller/TransaksiC.dart';
import 'package:easycount/app/pages/edit_transaksi_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailTransaksi extends StatelessWidget {
  final Map<String, dynamic> data;
  const DetailTransaksi({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    
  final DateTime date = (data['tgl_transaksi'] as Timestamp).toDate();
  final ocean = Color.fromRGBO(89, 119, 181, 1);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi', style: 
        GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        ),),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Transaksi',
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 151, 149, 149)
                )
              ),
              ),
              Text(data['jenisTransaksi'], 
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
              ),
              ),

              SizedBox(height: 8,),
              
              Text('Tanggal',
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 151, 149, 149)
                )
              ),
              ),
              Text(
                date.toString(), 
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
              ),
              ),
              
              SizedBox(height: 8,),
              
              Text('Catatan',
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 151, 149, 149)
                )
              ),
              ),
              Text(
                data['catatan'], 
              style: GoogleFonts.plusJakartaSans(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
              ),
              ),
            
            SizedBox(height: 50,),
            
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(68, 68, 68, 1),
              ),
              child: Table(  
                border: TableBorder.all(  
                  color: Colors.white,  
                  borderRadius: BorderRadius.circular(15)
                ),  
                children: [  
                  TableRow(  
                    children: [  
                      Padding(  
                        padding: EdgeInsets.all(12),  
                        child: Text(  
                          'Akun',  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontSize: 12,  
                              fontWeight: FontWeight.bold,  
                              color: Colors.white,  
                            ),  
                          ),  
                        ),  
                      ),  
                      Padding(  
                        padding: EdgeInsets.all(12),  
                        child: Text(  
                          'Debit',  
                          textAlign: TextAlign.right,  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontSize: 12,  
                              fontWeight: FontWeight.bold,  
                              color: Colors.white,  
                            ),  
                          ),  
                        ),  
                      ),  
                      Padding(  
                        padding: EdgeInsets.all(12),  
                        child: Text(  
                          'Credit',  
                          textAlign: TextAlign.right,  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontSize: 12,  
                              fontWeight: FontWeight.bold,  
                              color: Colors.white,  
                            ),  
                          ),  
                        ),  
                      ),  
                    ],  
                  ),  
                  TableRow(  
                    children: [  
                      Padding(  
                        padding: EdgeInsets.all(12),  
                        child: Text(  
                          data['id_debit'].toString(),  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontSize: 12,  
                              color: Colors.white,  
                            ),  
                          ),  
                        ),  
                      ),  
                      Padding(  
                        padding: EdgeInsets.all(12),  
                        child: Text(  
                         'Rp. ${data['nominal'].toString()}',
                          textAlign: TextAlign.right,  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontSize: 12,  
                              color: Colors.white,  
                            ),  
                          ),  
                        ),  
                      ),  
                      Padding(  
                        padding: EdgeInsets.all(12),  
                        child: Text(  
                          'Rp.0',  
                          textAlign: TextAlign.right,  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontSize: 12,  
                              color: Colors.white,  
                            ),  
                          ),  
                        ),  
                      ),  
                    ],  
                  ),  
                  TableRow(  
                    children: [  
                      Padding(  
                        padding: EdgeInsets.all(12),  
                        child: Text(  
                          data['id_kredit'].toString(),  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontSize: 12,  
                              color: Colors.white,  
                            ),  
                          ),  
                        ),  
                      ),  
                      Padding(  
                        padding: EdgeInsets.all(12),  
                        child: Text(  
                          'Rp.0',  
                          textAlign: TextAlign.right,  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontSize: 12,  
                              color: Colors.white,  
                            ),  
                          ),  
                        ),  
                      ),  
                      Padding(  
                        padding: EdgeInsets.all(12),  
                        child: Text(  
                         'Rp. ${data['nominal'].toString()}',
                          textAlign: TextAlign.right,  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontSize: 12,  
                              color: Colors.white,  
                            ),  
                          ),  
                        ),  
                      ),  
                    ],  
                  ),  
                ],  
              ),
            ),

            SizedBox(height: 50,),
            Row(  
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [  
                ElevatedButton(  
                  style: ElevatedButton.styleFrom(  
                    fixedSize: Size(120, 50),  
                    backgroundColor: ocean, // Warna biru (Ubah)  
                    shape: RoundedRectangleBorder(  
                      borderRadius: BorderRadius.circular(10),  
                    ),  
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),  
                  ),  
                  onPressed: () {  
                    Navigator.pushReplacement(  
                      context,  
                      MaterialPageRoute(builder: (context) => EditTransaksi(data: data,)),  
                    );  
                  },  
                  child: Text(  
                    'Ubah',  
                    style: GoogleFonts.poppins(  
                      color: Colors.white,  
                      fontWeight: FontWeight.bold,  
                      fontSize: 18,  
                    ),  
                  ),  
                ),  
                SizedBox(width: 16.0),  
                ElevatedButton(  
                  style: ElevatedButton.styleFrom(  
                    fixedSize: Size(120, 50),  
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(  
                      borderRadius: BorderRadius.circular(10),  
                    ),  
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),  
                  ),  
                  onPressed: () {  
                   TransaksiC().showConfirmDialog(context, data);
                  },  
                  child: Text(  
                    'Hapus',  
                    style: GoogleFonts.poppins(  
                      color: Colors.white,  
                      fontWeight: FontWeight.bold,  
                      fontSize: 18,  
                    ),  
                  ),  
                ),
              ],  
            )
          ],
        )
      ),
    );
  }
}