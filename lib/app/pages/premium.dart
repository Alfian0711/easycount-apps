import 'package:easycount/app/models/penggunaM.dart';
import 'package:easycount/app/pages/handle_payment.dart';
import 'package:easycount/app/pages/webview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/PremiumC.dart';
import '../controller/ProfileC.dart';
import '../services/payment_service.dart';

class Premium_View extends StatefulWidget {
  Premium_View({Key? key}) : super(key: key);

  @override
  State<Premium_View> createState() => _Premium_ViewState();
}

class _Premium_ViewState extends State<Premium_View> {
  final dataController = ProfileC(); 
  String? status, virtualAccount, bank, paymentType, url;
  bool? isPremium_;
 // Ambil stream dari controller
  @override
  void initState() {  
    super.initState();  
    ambilStatusPremium(); // Panggil fungsi untuk mengambil status premium  
  }  

  void ambilStatusPremium() {
    PremiumC().getPremiumData().listen((premiumList) {
      if (premiumList.isNotEmpty) {
        setState(() {
          isPremium_ = premiumList.first.isPremium; 
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
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final Color colorfont = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Premium",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul dan Deskripsi
            Image(
              image: AssetImage('assets/logo/logo2.png'),
              width: 100,
            ),
            SizedBox(height: 10),
            Text(
              "Berlangganan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorfont,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Akses semua fitur akuntansi. Coba selama 3 bulan hanya Rp. 40.000.",
              style: TextStyle(
                fontSize: 16,
                color: colorfont,
              ),
            ),
            SizedBox(height: 10),
            _buildPromoContainer(),
            SizedBox(height: 20),

            // Gradient Cards
            _buildGradientCard(
              title: "Mengapa Berlangganan?",
              features: [
                "Mengakses semua fitur akuntansi",
                "Melihat laporan keuangan lengkap",
                "Mengekspor laporan keuangan ke PDF dan Excel",
                "Mencari histori transaksi berdasarkan waktu",
              ],
              backgroundColors: [Color(0xFF4B6CB7), Color(0xFF182848)],
            ),
            SizedBox(height: 20),

            // Menggunakan StreamBuilder untuk mendapatkan data dari ProfileC
            StreamBuilder<List<PenggunaM>>(
              stream: dataController.Tampilpengguna(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data available');
                } else {
                  var penggunaData = snapshot.data!;

                  var nama = penggunaData.first.name;
                  var uid = penggunaData.first.uid;
                  var nama_bisnis = penggunaData.first.name_bussiness;
                  var email = penggunaData.first.email;
                  var nohp = penggunaData.first.phone;

                  return GestureDetector(
                    onTap: () async {
                      if(isPremium_ == false){
                        try {
                          // Panggil API untuk mendapatkan Snap Token
                          final response = await MidtransService().createTransaction(23000, nama, nama_bisnis, email, nohp, uid);
                          if (response.containsKey('token')) {
                            final snapToken = response['token'];

                            final resultFromPayment = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentWebView(snapToken: snapToken),
                              ),
                            );
                          if (resultFromPayment != null) {
                            final status = resultFromPayment['status'];
                            final virtualAccount = resultFromPayment['virtualAccount'];
                            final bank = resultFromPayment['bank'];
                            final paymentType = resultFromPayment['payment_type'];
                            final url = resultFromPayment['url'];

                            setState(() {
                              // Periksa nilai status yang diterima
                              if (status == 'success') {
                                this.status = 'success';
                              } else if (status == 'failed') {
                                this.status = 'failed';
                              } else if (status == 'pending') {
                                this.status = 'pending';
                                this.virtualAccount=virtualAccount;
                                this.bank=bank;
                                this.paymentType=paymentType;
                                this.url=url;
                              } else {
                                this.status = null; // Menangani kemungkinan nilai lain
                              }
                            });
                          } else {
                            print('Tidak ada data status dan VA');
                          }

                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Gagal mendapatkan Snap Token')),
                            );
                          }
                        } catch (e) {
                          // Tangani error saat memanggil API
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Terjadi kesalahan: $e')),
                          );
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(' Anda sudah Berlangganan!')),
                        );
                      }
                    },
                    child: _buildGradientCard(
                      title: "Premium Mini",
                      price: "Rp. 23.000",
                      subText: "Selama 1 bulan",
                      features: [
                        "Mengakses semua fitur akuntansi",
                        "Melihat laporan keuangan lengkap",
                        "Mengekspor laporan keuangan ke PDF dan Excel",
                        "Mencari histori transaksi berdasarkan waktu",
                      ],
                      backgroundColors: [Color(0xFF8E44AD), Color(0xFF3A1C71)],
                    ),
                  );
                }
              },
            ),
            if (status == 'pending') ...[
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context)=>HandlePayment(result:status, virtualAccount: virtualAccount, bank: bank, paymentType: paymentType, url:url)));
                },
                child: Text('Lanjutkan Pembayaran'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Widget untuk bagian Promo Singkat
  Widget _buildPromoContainer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "Tawaran Waktu Terbatas!",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // Widget Reusable untuk Gradient Card
  Widget _buildGradientCard({
    required String title,
    String? price,
    String? subText,
    required List<String> features,
    required List<Color> backgroundColors,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (price != null)
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          if (subText != null)
            Text(
              subText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: features
                .map((feature) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: Colors.white70, size: 16),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
