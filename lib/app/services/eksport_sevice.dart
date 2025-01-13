import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'dart:io';
import 'package:excel/excel.dart';
// import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Eksport {

void exportToPdf(List<Map<String, dynamic>> transactions, name_transaction, BuildContext context) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Usaha UMKM ', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text(name_transaction, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                if(name_transaction == ' Laporan Jurnal Umum')...[
                  // Header Row
                  pw.TableRow(children: [
                    pw.Text('Tanggal', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Akun', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Kredit', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Debit', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Deskripsi', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ]),
                  // Data Rows
                  ...transactions.map((data) {
                    return pw.TableRow(children: [
                      pw.Text(DateFormat('dd-MM-yyyy').format((data['tgl_transaksi'] as Timestamp).toDate())),
                      pw.Text(data['id_debit'] ?? ''),
                      pw.Text(data['id_kredit'] ?? ''),
                      pw.Text('Rp. ${data['nominal']}'),
                      pw.Text('Rp. ${data['nominal']}'),
                      pw.Text(data['catatan'] ?? ''),
                    ]);
                  }).toList(),
                ] else...[
                  // Header Row
                  pw.TableRow(children: [
                    pw.Text('Tanggal', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Deskripsi', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('Nominal', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ]),
                  // Data Rows
                  ...transactions.map((data) {
                    return pw.TableRow(children: [
                      pw.Text(DateFormat('dd-MM-yyyy').format((data['tgl_transaksi'] as Timestamp).toDate())),
                      pw.Text(data['catatan'] ?? ''),
                      pw.Text('Rp. ${data['nominal']}'),
                    ]);
                  }).toList(),
                ]
              ],
            ),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(onLayout: (format) async => pdf.save());
}


void exportToExcel(List<Map<String, dynamic>> transactions, name_transaction) async {
  var excel = Excel.createExcel();
  // Buat Sheet
  Sheet sheet = excel['Laporan Jurnal Umum'];

  // Tambahkan Header
  sheet.appendRow(['Tanggal', 'Deskripsi', 'Debit', 'Kredit']);

  // Tambahkan Data
  for (var data in transactions) {
    sheet.appendRow([
      DateFormat('dd-MM-yyyy').format((data['tgl_transaksi'] as Timestamp).toDate()),
      data['catatan'] ?? '',
      'Rp. ${data['nominal']}',
      'Rp. ${data['nominal']}',
    ]);
  }

  // Simpan File
  var bytes = excel.save();
  File("Laporan_Jurnal_Umum.xlsx")
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes!);

  print("Excel berhasil dibuat");
}

}

