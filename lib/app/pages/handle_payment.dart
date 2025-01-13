import 'package:easycount/app/controller/PremiumC.dart';
import 'package:flutter/material.dart';  
import 'package:flutter/services.dart';  
import 'package:google_fonts/google_fonts.dart';

import '../services/payment_service.dart';
// import '../widgets/bottomBar.dart';  

class HandlePayment extends StatefulWidget {  
  final result, virtualAccount, bank, paymentType, url;  
  HandlePayment({super.key, required this.result, required this.virtualAccount, required this.bank, required this.paymentType, required this.url});  

  @override  
  _HandlePaymentState createState() => _HandlePaymentState();  
}  

class _HandlePaymentState extends State<HandlePayment> {  
  bool _isPaymentSuccess = false;  

  Future<void> _refreshData() async {  
    setState(() {  
      // Update the payment status  
      _isPaymentSuccess = !_isPaymentSuccess;  
    ScaffoldMessenger.of(context).showSnackBar(  
      SnackBar(content: Text('Pembayaran Sukses.')),  
    );  
      // Navigator.pushReplacement(context,  
      //   MaterialPageRoute(builder: (context) => Bottombar(initialIndex: 0,)),
      // );  
      
    });  
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay for the refresh  
  }  

  @override  
  Widget build(BuildContext context) {  
    final ocean = Color.fromRGBO(89, 119, 181, 1);  

    return Scaffold(  
      appBar: AppBar(  
        title: Text('Lanjutkan Pembayaran'),  
        automaticallyImplyLeading: false,  
      ),  
      body: RefreshIndicator(  
        onRefresh: _refreshData,  
        child: Container(  
          margin: EdgeInsets.all(20),  
          child: Column(  
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: [  
              if (_isPaymentSuccess) ...[  
                // Tampilkan konten untuk pembayaran berhasil  
                Text(  
                  'Pembayaran Berhasil',  
                  style: GoogleFonts.plusJakartaSans(  
                    textStyle: TextStyle(  
                      fontSize: 20,  
                      fontWeight: FontWeight.bold,  
                      color: Colors.green,  
                    ),  
                  ),  
                ),  
                SizedBox(height: 16),  
              ] else ...[  
                // Tampilkan konten untuk pembayaran belum berhasil  
                Text(  
                  'Sedang Memproses Pembayaran',  
                  style: GoogleFonts.plusJakartaSans(  
                    textStyle: TextStyle(  
                      fontSize: 20,  
                      fontWeight: FontWeight.bold,  
                      color: Colors.orange,  
                    ),  
                  ),  
                ),  
                SizedBox(height: 16),  
              ],  
              Text(  
                'Status',  
                style: GoogleFonts.plusJakartaSans(  
                  textStyle: TextStyle(  
                    fontSize: 18,  
                    color: Color.fromARGB(255, 151, 149, 149)  
                  )  
                ),  
              ),  
              Text(  
                widget.result,  
                style: GoogleFonts.plusJakartaSans(  
                  textStyle: TextStyle(  
                    fontSize: 20,  
                    fontWeight: FontWeight.bold  
                  )  
                ),  
              ),  

              SizedBox(height: 8),  

              GestureDetector(  
                onTap: () {  
                  Clipboard.setData(ClipboardData(text: widget.virtualAccount));  
                  ScaffoldMessenger.of(context).showSnackBar(  
                    SnackBar(  
                      content: Text('Nomor Virtual Account disalin ke clipboard'),  
                      duration: Duration(seconds: 2),  
                    ),  
                  );  
                },  
                child: Row(  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                  children: [  
                    Column(  
                      crossAxisAlignment: CrossAxisAlignment.start,  
                      children: [  
                        Text(  
                          'Nomor Virtual Account',  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontSize: 18,  
                              color: Color.fromARGB(255, 151, 149, 149),  
                            ),  
                          ),  
                        ),  
                        SizedBox(height: 8),  
                        Text(  
                          widget.virtualAccount,  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontSize: 20,  
                              fontWeight: FontWeight.bold,  
                            ),  
                          ),  
                        ),  
                      ],  
                    ),  
                    Icon(  
                      Icons.copy,  
                      color: Color.fromARGB(255, 151, 149, 149),  
                    ),  
                  ],  
                ),  
              ),  

              SizedBox(height: 8),  

              Text(  
                'Bank',  
                style: GoogleFonts.plusJakartaSans(  
                  textStyle: TextStyle(  
                    fontSize: 18,  
                    color: Color.fromARGB(255, 151, 149, 149)  
                  )  
                ),  
              ),  
              Text(  
                widget.bank,  
                style: GoogleFonts.plusJakartaSans(  
                  textStyle: TextStyle(  
                    fontSize: 20,  
                    fontWeight: FontWeight.bold  
                  )  
                ),  
              ),  

              Text(  
                'Metode Pembayaran',  
                style: GoogleFonts.plusJakartaSans(  
                  textStyle: TextStyle(  
                    fontSize: 18,  
                    color: Color.fromARGB(255, 151, 149, 149)  
                  )  
                ),  
              ),  
              Text(  
                widget.paymentType,  
                style: GoogleFonts.plusJakartaSans(  
                  textStyle: TextStyle(  
                    fontSize: 20,  
                    fontWeight: FontWeight.bold  
                  )  
                ),  
              ),  

              SizedBox(height: 50),  
              Row(  
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
                children: [  
                  ElevatedButton(  
                    style: ElevatedButton.styleFrom(  
                      fixedSize: Size(120, 50),  
                      backgroundColor: ocean,  
                      shape: RoundedRectangleBorder(  
                        borderRadius: BorderRadius.circular(10),  
                      ),  
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),  
                    ),  
                    onPressed: () {  
                      // Jika pembayaran berhasil, update status dan kembalikan ke halaman sebelumnya  
                      setState(() {  
                        PremiumC().checkPremiumStatus();
                        _isPaymentSuccess = true;  
                      });  
                      Navigator.pop(context, {  
                        'result': widget.result,  
                        'virtualAccount': widget.virtualAccount,  
                        'bank': widget.bank,  
                        'paymentType': widget.paymentType  
                      });  
                    },  
                    child: Text(  
                      'Kembali',  
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
                      
                    },  
                    child: Text(  
                      'Cancel',  
                      style: GoogleFonts.poppins(  
                        color: Colors.white,  
                        fontWeight: FontWeight.bold,  
                        fontSize: 18,  
                      ),  
                    ),  
                  ),  
                ],  
              ), 
              SizedBox(height: 50,),
              Center(
                child: ElevatedButton(  
                      style: ElevatedButton.styleFrom(  
                        fixedSize: Size(120, 50),  
                        backgroundColor: Colors.red,  
                        shape: RoundedRectangleBorder(  
                          borderRadius: BorderRadius.circular(10),  
                        ),  
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),  
                      ),  
                     onPressed: () async {  
                      final uri = Uri.parse(widget.url);  
                       final idOrder = uri.queryParameters['order_id'];  
                        final transactionData = await MidtransService().checkTransaction(idOrder);  
                          if(transactionData != null){
                             final status = transactionData['status_code'];  
                             if(status == '200'){

                              PremiumC().onPaymentSuccess(widget.url, context);
                              _refreshData();

                             }else{
                              ScaffoldMessenger.of(context).showSnackBar(  
                                SnackBar(content: Text('pembayaran belum lunas.')),  
                              ); 
                             }
                          }else{
                            print('var transaction null');
                          }
                      },  
                      child: Text(  
                        'Cek',  
                        style: GoogleFonts.poppins(  
                          color: Colors.white,  
                          fontWeight: FontWeight.bold,  
                          fontSize: 18,  
                        ),  
                      ),  
                    ),
              ),  
            ],  
          ),  
        ),  
      ),  
    );  
  }  
}