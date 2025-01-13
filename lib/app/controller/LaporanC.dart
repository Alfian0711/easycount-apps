import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/eksport_sevice.dart';

class LaporanController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;  

  // Observable variable to hold transaksi list
  var transaksiList_perubahanModal = <Map<String, dynamic>>[].obs;
  var transaksiList = <Map<String, dynamic>>[].obs;
  String ? name_transaction ;
  var totalDebit = 0.0.obs;
  var totalKredit = 0.0.obs;

  // var for laba rugi
  var transaksiList_labrug = <Map<String, dynamic>>[].obs;
  var kelompokData = {}.obs;
  var totalPendapatan = 0.0.obs;
  var totalBeban = 0.0.obs;
  var labaRugi = 0.0.obs;

  // Fetch data from Firestore
  void Tampil_JurnalUmum() async {
    try {
      String ? uid = auth.currentUser?.uid; 
      var snapshot = await FirebaseFirestore.instance.collection('transaksi').where('uid', isEqualTo: uid).get();

      // Reset totals
      double debitSum = 0.0;
      double kreditSum = 0.0;

      // Process each transaction
      var transactions = await Future.wait(snapshot.docs.map((doc) async {
        var data = doc.data();
        double nominal = double.tryParse(data['nominal'].toString()) ?? 0;

        // Add to totals
        debitSum += nominal;
        kreditSum += nominal;

        // Fetch related accounts
        String? idKredit = data['id_kredit'];
        String? idDebit = data['id_debit'];

        if (idKredit != null && idDebit != null) {
          var kreditSnapshot = await FirebaseFirestore.instance.collection('akun').doc(idKredit).get();
          var debitSnapshot = await FirebaseFirestore.instance.collection('akun').doc(idDebit).get();

          data['nama_akun_kredit'] = kreditSnapshot.exists ? kreditSnapshot['nama_akun'] : null;
          data['nama_akun_debit'] = debitSnapshot.exists ? debitSnapshot['nama_akun'] : null;
        }

        return data;
      }).toList());

      // Update state
      transaksiList.assignAll(transactions);
      totalDebit.value = debitSum;
      totalKredit.value = kreditSum;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e');
    }
  }

   void exportToPdf(BuildContext context, name_transaction) {
    if (transaksiList.isNotEmpty) {
      Eksport().exportToPdf(transaksiList, name_transaction,context);
    } else {
      Get.snackbar('Error', 'No data to export');
    }
  }

  void exportToExcel(name_transaction) {
    if (transaksiList.isNotEmpty) {
      Eksport().exportToExcel(transaksiList, name_transaction);
    } else {
      Get.snackbar('Error', 'No data to export');
    }
  }


// fungsi untuk kebutuhan data perubahan modal  
void Tampil_PerubahanModal() async {
  try {
    // Ambil UID pengguna saat ini
    String? uid = auth.currentUser?.uid;

    if (uid == null) {
      Get.snackbar('Error', 'User is not authenticated');
      return;
    }

    // Ambil data transaksi dari Firestore yang sesuai dengan UID
    var snapshot = await FirebaseFirestore.instance
        .collection('transaksi')
        .where('uid', isEqualTo: uid)
        .get();

    // Proses setiap transaksi
    var filteredTransactions = await Future.wait(snapshot.docs.map((doc) async {
      var data = doc.data();        

      // Filter data sesuai kondisi tertentu
      String? idKredit = data['id_kredit'];
      if (idKredit == '3-001' || idKredit == '3-002') {
        double modal = double.tryParse(data['nominal'].toString()) ?? 0;
        data['totalmodal'] = modal+labaRugi.value;

        // Ambil data akun kredit terkait
        var kreditSnapshot = await FirebaseFirestore.instance
            .collection('akun')
            .doc(idKredit)
            .get();

        data['nama_akun_kredit'] =
            kreditSnapshot.exists ? kreditSnapshot['nama_akun'] : 'Tidak Ditemukan';
        return data;
      }

      return null;
    }).toList());

    // Hapus elemen null dari hasil
    var validTransactions = filteredTransactions.where((e) => e != null).toList();

    // Update state dengan transaksi valid
    transaksiList_perubahanModal.assignAll(validTransactions.cast<Map<String, dynamic>>());
  } catch (e) {
    Get.snackbar('Error', 'Failed to fetch data: $e');
  }
}

  // fungsi untuk kebutuhan data laba rugi
@override
void onInit() {
  super.onInit();

  // Listener untuk perubahan pengguna
  auth.authStateChanges().listen((user) {
    if (user != null) {
      Tampil_LabaRugi(); // Panggil ulang fungsi saat pengguna berganti akun
    }
  });

  // Panggilan awal untuk pengguna yang sudah login
  if (auth.currentUser != null) {
    Tampil_LabaRugi();
  }
}


  // Fetch data dari Firestore
  void Tampil_LabaRugi() {
  try {
    String? uid = auth.currentUser?.uid;

    if (uid == null) {
      Get.snackbar('Error', 'User is not authenticated');
      return;
    }

    // Gunakan snapshots untuk mendapatkan update real-time
    FirebaseFirestore.instance
        .collection('transaksi')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .listen((snapshot) async {
      // Kosongkan data lama
      transaksiList_labrug.clear();
      kelompokData.clear();

      List<Map<String, dynamic>> fetchedData = [];

      // Proses setiap dokumen
      for (var doc in snapshot.docs) {
        var data = doc.data();
        fetchedData.add(await lengkapiNamaAkun(data));
      }

      // Perbarui data ke Rx variabel
      transaksiList_labrug.value = fetchedData;
      kelompokkanData(); // Kelompokkan data sesuai kategori
      hitungTotal();     // Hitung total pendapatan, beban, dan laba rugi
    });
  } catch (e) {
    print("Error in real-time listener: $e");
  }
}

// Fungsi untuk melengkapi nama akun
Future<Map<String, dynamic>> lengkapiNamaAkun(Map<String, dynamic> data) async {
  String? idKredit = data['id_kredit'];
  String? idDebit = data['id_debit'];

  if (idKredit != null) {
    var kreditSnapshot = await FirebaseFirestore.instance
        .collection('akun')
        .doc(idKredit)
        .get();
    if (kreditSnapshot.exists) {
      data['nama_akun_kredit'] =
          (kreditSnapshot.data() as Map<String, dynamic>)['nama_akun'];
    }
  }

  if (idDebit != null) {
    var debitSnapshot = await FirebaseFirestore.instance
        .collection('akun')
        .doc(idDebit)
        .get();
    if (debitSnapshot.exists) {
      data['nama_akun_debit'] =
          (debitSnapshot.data() as Map<String, dynamic>)['nama_akun'];
    }
  }

  return data;
}


  // Kelompokkan data berdasarkan kategori
  void kelompokkanData() {
    Map<String, List<Map<String, dynamic>>> kelompok = {
      'Pendapatan dari Penjualan': [],
      'Harga Pokok Penjualan': [],
      'Beban Operasional': [],
      'Pendapatan Lainnya': [],
      'Beban Lainnya': [],
    };

    for (var data in transaksiList_labrug) {
      if (data['jenisTransaksi'] == 'Pemasukan' &&
          data['id_kredit'] == '2-001') {
        kelompok['Pendapatan dari Penjualan']?.add(data);
      } else if (data['jenisTransaksi'] == 'Pengeluaran' &&
          (data['id_debit'] == '6-001' || data['id_debit'] == '6-002')) {
        kelompok['Harga Pokok Penjualan']?.add(data);
      } else if (data['jenisTransaksi'] == 'Pengeluaran' &&
          data['id_debit'] == '6-003') {
        kelompok['Beban Operasional']?.add(data);
      } else if (data['jenisTransaksi'] == 'Pemasukan' &&
          (data['id_kredit'] == '2-002' || data['id_kredit'] == '2-003')) {
        kelompok['Pendapatan Lainnya']?.add(data);
      } 
      // else {
      //   kelompok['Beban Lainnya']?.add(data);
      // }
    }

    kelompokData.value = kelompok;
  }

  // Hitung total pendapatan, beban, dan laba rugi
  void hitungTotal() {
  double pendapatan = 0;
  double beban = 0;

  kelompokData.forEach((kategori, dataKategori) {
    double totalKategori = dataKategori.fold(0.0, (sum, item) {
      double nominal = item['nominal']?.toDouble() ?? 0.0; 
      return sum + nominal;
    });

    // print('Kategori: $kategori, Total Kategori: $totalKategori'); 

    if (kategori.startsWith('Pendapatan')) {
      pendapatan += totalKategori;
    } else if (kategori.startsWith('Beban') || kategori == 'Harga Pokok Penjualan') {
      beban += totalKategori;
    }
  });

  totalPendapatan.value = pendapatan;
  totalBeban.value = beban;
  labaRugi.value = pendapatan - beban;

  // print('Pendapatan: $pendapatan, Beban: $beban, Laba Rugi: ${pendapatan - beban}'); 
}
}

