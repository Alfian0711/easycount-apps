import 'package:easycount/app/pages/laporan/lapkeu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/PremiumC.dart';
import '../widgets/bottomBar.dart';
import 'laporan/labarugi.dart';
import 'laporan/lap_jrnl.dart';
import 'laporan/perubahan_modal.dart';
import 'laporan/transaksi.dart';

class Laporan extends StatefulWidget {  
  const Laporan({super.key});  

  @override  
  _LaporanState createState() => _LaporanState();  
}

class _LaporanState extends State<Laporan> {  
  bool? isPremium_ ; 

  @override  
  void initState() {  
    super.initState();  
    ambilStatusPremium(); // Panggil fungsi untuk mengambil status premium  
  }  

  void ambilStatusPremium() {
    PremiumC().getPremiumData().listen((premiumList) {
      if (premiumList.isNotEmpty) {
        setState(() {
          isPremium_ = premiumList.first.isPremium; // Simpan status premium
        });
      } else {
        setState(() {
          isPremium_ = false;
        });
      }
    }, onError: (error) {
      print('Terjadi kesalahan: $error');
      setState(() {
        isPremium_ = false; // Default jika ada kesalahan
      });
    });
  }

  @override  
  Widget build(BuildContext context) {  
    final List<Map<String, dynamic>> buttons = [  
      {'title': 'Transaksi', 'page': Transaksi()},  
      {'title': 'Jurnal Umum', 'page': JurnalUmumPage()},  
      {'title': 'Laba Rugi', 'page': LapLabarugi()},  
      {'title': 'Perubahan Modal', 'page': PerubahanModalPage()},  
      {'title': 'Laporan Keuangan', 'page': LaporanKeuangan()},  
    ];  

    return Scaffold(  
      appBar: AppBar(  
        title: Text(  
          'Laporan',  
          style: GoogleFonts.poppins(  
            textStyle: const TextStyle(  
              fontSize: 20,  
              fontWeight: FontWeight.bold,  
            ),  
          ),  
        ),  
        automaticallyImplyLeading: false,
      ),  
      body: isPremium_ == null  
          ? const Center(child: CircularProgressIndicator()) // Tampilkan loading jika status belum diambil  
          : ListView(  
              padding: const EdgeInsets.only(top: 15),  
              children: buttons.map((button) {  
                return ElevatedButton(  
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero
                    ),  
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),  
                  ),  
                  onPressed: () {  
                    if (button['title'] == 'Laporan Keuangan' && isPremium_ == false) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Ingin berlangganan?',
                              style: GoogleFonts.plusJakartaSans(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(300, 50),
                                  backgroundColor: const Color.fromRGBO(89, 119, 181, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(  
                                    context,  
                                    MaterialPageRoute(builder: (context) => Bottombar(initialIndex: 1,)),  
                                  ); // Menutup dialog
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Berlangganan',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.star_border_purple500, color: Colors.white),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Navigasi ke halaman jika premium atau bukan "Laporan Keuangan"
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => button['page']),
                      );
                    }
                  },
                  child: Align(  
                    alignment: Alignment.centerLeft,  
                    child: Text(  
                      button['title'],  
                      style: GoogleFonts.poppins(  
                        textStyle: TextStyle(  
                          fontSize: 18,  
                          fontWeight: FontWeight.w500,  
                          color: Theme.of(context).brightness == Brightness.dark  
                              ? Colors.grey[200]  
                              : Color.fromRGBO(68, 68, 68, 1),  
                        ),  
                      ),  
                    ),  
                  ),  
                );  
              }).toList(),  
            ),  
    );  
  }  
}  


