import 'package:cloud_firestore/cloud_firestore.dart';

class TransaksiM {
  final uid;
  final selectedDate;
  final catatan;
  final selectedTime;
  final selectedJenisTransaksi;
  final nominal; 
  final debit;
  final kredit;

  TransaksiM({
    required this.uid,
    required this.selectedDate,
    required this.catatan,
    required this.selectedTime,
    required this.selectedJenisTransaksi,
    required this.nominal,
    required this.debit,
    required this.kredit,
  });

  factory TransaksiM.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return TransaksiM(
      uid: data['uid'],
      selectedDate: data['tgl_transaksi'] ?? '',
      catatan: data['catatan'] ?? '',
      selectedTime: data['waktu'] ?? '',
      selectedJenisTransaksi: data['jenisTransaksi'] ?? '',
      nominal: data['nominal'] != null ? (data['nominal'] as num).toDouble() : 0.0, 
      debit: data['id_debit'] ?? '',
      kredit: data['id_kredit'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'tgl_transaksi': selectedDate,
      'catatan': catatan,
      'waktu': selectedTime,
      'jenisTransaksi': selectedJenisTransaksi,
      'nominal': nominal, 
      'id_debit': debit,
      'id_kredit': kredit,
    };
  }
}
