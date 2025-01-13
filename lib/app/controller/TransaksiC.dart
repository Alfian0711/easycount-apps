import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easycount/app/widgets/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/transaksiM.dart';
import '../widgets/bottomBar.dart';

class TransaksiC {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;  

  CollectionReference transaksi = FirebaseFirestore.instance.collection('transaksi');

  Future<void> Aksi_tambah({
  selectedDate,
  required selectedTime,
  required String selectedJenisTransaksi,
  required selected_kredit,
  required selected_debit,
  required nominal,
  required String catatan,
  required BuildContext context,
}) async {
  String? uid = auth.currentUser?.uid;

  Timestamp timestamp = Timestamp.fromDate(selectedDate);  
  String formattedTime = '${selectedTime.hour}:${selectedTime.minute}';  
  
  TransaksiM transaksiM = TransaksiM(
    uid:uid,
    selectedDate: timestamp,  
    selectedTime: formattedTime,
    selectedJenisTransaksi: selectedJenisTransaksi,
    nominal: nominal,
    debit: selected_debit,
    kredit: selected_kredit,
    catatan: catatan,
  );

  return transaksi
      .doc()
      .set(transaksiM.toMap())
      .then((value) {
        _showDialog(context, 'Berhasil mencatatkan Transaksi', 'Transaksi berhasil disimpan!');
      })
      .catchError((error) {
        _showDialog(context, 'Gagal mencatatkan Transaksi', 'Gagal menyimpan Transaksi!');
      });
}


Future<void> Aksi_ubah({
  required String documentId,
  required DateTime selectedDate,
  required TimeOfDay selectedTime,
  required String selectedJenisTransaksi,
  required  selected_kredit,
  required  selected_debit,
  required nominal,
  required String catatan,
  required BuildContext context,
}) async {
  String? uid = auth.currentUser?.uid;
  
    Timestamp timestamp = Timestamp.fromDate(selectedDate);  
    String formattedTime = '${selectedTime.hour}:${selectedTime.minute}'; 

    TransaksiM transaksiM = TransaksiM(
      uid: uid,
      selectedDate: timestamp,
      selectedTime: formattedTime,
      selectedJenisTransaksi: selectedJenisTransaksi,
      nominal: nominal,
      debit: selected_debit,
      kredit: selected_kredit,
      catatan: catatan,
    );

  try{
    await transaksi.doc(documentId).update(transaksiM.toMap());
      _showDialog(context, 'Berhasil Mengubah Transaksi', 'Transaksi berhasil diubah!');
    }catch(error) {
      _showDialog(context, 'Gagal Mengubah Transaksi', 'Gagal mengubah transaksi: $error');
    };
  // }
}


  Stream<QuerySnapshot<Object?>> Tampildata() {  
    String ? uid = auth.currentUser?.uid; 
  return transaksi
  .where('uid', isEqualTo: uid)
  .snapshots();  
  }

  Stream<QuerySnapshot> Cari_transaksi(String query) {
    return transaksi
        .where('catatan', isGreaterThanOrEqualTo: query)
        .where('catatan', isLessThanOrEqualTo: query + '\uf8ff')
        .snapshots();
  }

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


  Future<void> Aksi_hapus({  
  required BuildContext context, 
  required String documentId, 
  }) async {  
    try {  
   
           return transaksi
          .doc(documentId)  
          .delete()
          .then((value) {
          _showDialog(context, 'Berhasil', 'Berhasil Menghapus Transaksi');  

          })
          .catchError((error) { 
          _showDialog(context, 'Kesalahan', 'Gagal Menghapus Transaksi');  
          });

    } catch (error) {  
      print('Error getting document: $error');  
      _showDialog(context, 'Kesalahan', 'Gagal mengambil dokumen: $error');  
    }  
  }

  void _showDialog(BuildContext context, status, textstatus) {  
    showDialog(  
      context: context,  
      builder: (BuildContext context) {  
        return AlertDialog(  
          title: Text(status),  
          content: Text(textstatus),  
          actions: [  
            TextButton(  
              child: Text('OK'),  
              onPressed: () async{
                if(status == 'Berhasil mencatatkan Transaksi')  {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Bottombar(initialIndex: 0,)),
                  ); 
                }
                else{
                   Navigator.pushReplacement(  
                    context,  
                    MaterialPageRoute(builder: (context) => Bottombar(initialIndex: 0,)), 
                  );
                }
              },  
            ),  
          ],  
        );  
      },  
    );  
  } 
  
  Future<bool?> showConfirmDialog(BuildContext context, data) {  
    return showDialog<bool>(  
      context: context,  
      builder: (context) {  
        return ConfirmDialog(data: data,);  
      },  
    );  
  }   
}