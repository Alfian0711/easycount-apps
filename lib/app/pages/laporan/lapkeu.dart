import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../controller/LaporanC.dart';

class LaporanKeuangan extends StatelessWidget {
  final LaporanController controller = Get.put(LaporanController());

  @override
  Widget build(BuildContext context) {
    controller.Tampil_PerubahanModal();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perubahan Modal',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          // Header
          Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromRGBO(68, 68, 68, 1)
                  : Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.date_range_sharp, size: 30),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                  },
                  child: Text(
                    'Hari ini',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                Text(DateFormat('dd MMM yyyy').format(DateTime.now())),
                Spacer(),
                TextButton(
                  onPressed: () {
                    print('under development');
                  },
                  child: Text(
                    'PDF',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('under development');
                  },
                  child: Text(
                    'Excel',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 6),

          // Transactions List
          Expanded(
            child: Obx(() {
              if (controller.transaksiList_perubahanModal.isEmpty) {
                return Center(child: Text('Data Kosong'));
              }
              return ListView.builder(
                itemCount: controller.transaksiList_perubahanModal.length,
                itemBuilder: (context, index) {
                  var data = controller.transaksiList_perubahanModal[index];

                  var modal = data['nominal'];
                  var pendapatan = controller.totalPendapatan.value;
                  var kas = modal + pendapatan; 

                  return Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Color.fromRGBO(68, 68, 68, 1)
                            : Colors.grey[200],
                      ),
                      child: Column(  
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Laporan Posisi Keuangan',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy').format(
                                  (data['tgl_transaksi'] as Timestamp).toDate(),
                                ),
                                style: TextStyle(fontSize: 15, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Text(
                                'Equitas',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                    'Total Modal',
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                                  ),                              
                              Text('Rp. ${data['totalmodal'].toStringAsFixed(0)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Text(
                                'Liabilitas',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                    'Total Liabilitas',
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                                  ),                              
                              Text('Rp. 0', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                            ],
                          ),
                          SizedBox(height: 15,),
                          Divider(),
                          SizedBox(height: 15,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total L + E',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),                            
                              Text('Rp. ${data['totalmodal'].toStringAsFixed(0)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                            ],
                          ),

                          SizedBox(height: 15,),

                          Text(
                                'Assets',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                    'Kas',
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                                  ),                              
                              Text('Rp. ${kas.toStringAsFixed(0)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                    'Piutang Usaha',
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                                  ),                              
                              Text('Rp. 0', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                    'Persediaan',
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                                  ),                              
                              Text('Rp. 0', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                    'Pembelian',
                                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
                                  ),                              
                              Text('Rp. ${controller.totalBeban.toStringAsFixed(0)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
                            ],
                          ),
                          
                          SizedBox(height: 15,),
                          Divider(),
                          SizedBox(height: 15,),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Assets',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),                            
                              Text('Rp. ${data['totalmodal'].toStringAsFixed(0)}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
