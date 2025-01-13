import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../controller/LaporanC.dart';

class JurnalUmumPage extends StatelessWidget {
  final LaporanController controller = Get.put(LaporanController());

  @override
  Widget build(BuildContext context) {
    // Fetch data when the page loads
    controller.Tampil_JurnalUmum();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jurnal Umum',
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
                  onPressed: () => controller.exportToPdf(context, 'Laporan Jurnal Umum'),
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
                  onPressed: () => controller.exportToExcel('Laporan Jurnal Umum'),
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
              if (controller.transaksiList.isEmpty) {
                return Center(child: Text('Data Kosong'));
              }
              return ListView.builder(
                itemCount: controller.transaksiList.length,
                itemBuilder: (context, index) {
                  var data = controller.transaksiList[index];
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
                                data['jenisTransaksi'] ?? 'No description',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy').format(
                                  (data['tgl_transaksi'] as Timestamp).toDate(),
                                ),
                                style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${data['id_debit']} ${data['nama_akun_debit']} (D)'),
                              Text('Rp. ${data['nominal']}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${data['id_kredit']} ${data['nama_akun_kredit']} (C)'),
                              Text('Rp. ${data['nominal']}'),
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

          // Totals
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromRGBO(68, 68, 68, 1)
                  : Colors.grey[200],
            ),
            child: Obx(() {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Debit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Kredit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${controller.totalDebit.value.toStringAsFixed(0)}', style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold)),
                      Text('${controller.totalKredit.value.toStringAsFixed(0)}', style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
