import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/LaporanC.dart';

class LapLabarugi extends StatelessWidget {
  final LaporanController controller = Get.put(LaporanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Labarugi',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
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
                  child: Text('Hari ini'),
                ),
                Text(DateFormat('dd MMM yyyy').format(DateTime.now())),
                Spacer(),
                TextButton(
                  onPressed: () => controller.exportToPdf(context, 'Laporan Laba Rugi'),
                  child: Text('PDF'),
                ),
                TextButton(
                  onPressed: () => controller.exportToExcel('Laporan Laba Rugi'),
                  child: Text('Excel'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.transaksiList_labrug.isEmpty) {
                return Center(child: Text('Data Kosong'));
              }

              return ListView(
                children: [
                  ...controller.kelompokData.entries.map((entry) {
                    var kategori = entry.key;
                    var dataKategori = entry.value;

                    double totalKategori = dataKategori.fold(0.0, (sum, item) => sum + (item['nominal'] ?? 0.0));

                    return Container(
                      margin: EdgeInsets.all(3),
                      padding: EdgeInsets.all(12),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color.fromRGBO(68, 68, 68, 1)
                          : Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kategori,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ...dataKategori.map((item) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${item['jenisTransaksi'] == 'Pemasukan' ? item['id_kredit'] : item['id_debit']} '
                                    '${item['jenisTransaksi'] == 'Pemasukan' ? item['nama_akun_kredit'] : item['nama_akun_debit']}',
                                  ),
                                  Text(
                                    'Rp. ${item['nominal']?.toStringAsFixed(0)}',
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('Rp. ${totalKategori.toStringAsFixed(0)}', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  Container(
                    margin: EdgeInsets.all(3),
                    padding: EdgeInsets.all(12),
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromRGBO(68, 68, 68, 1)
                        : Colors.grey[200],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Laba Bersih',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rp. ${controller.labaRugi.toStringAsFixed(0)}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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
