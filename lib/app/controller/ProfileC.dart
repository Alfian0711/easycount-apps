import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easycount/app/widgets/bottomBar.dart';  
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';  
import '../models/penggunaM.dart';

class ProfileC {  
  FirebaseFirestore firestore = FirebaseFirestore.instance;  
  FirebaseAuth auth = FirebaseAuth.instance;  

  CollectionReference pengguna = FirebaseFirestore.instance.collection('pengguna');  
  
  Future<void> AddPengguna({  
    required String namaUsaha,  
    required String nama,  
    required String alamat,  
    required String status,  
    required String phone,  
    required BuildContext context,  
  }) async {  
    String? uid = auth.currentUser?.uid;  

    if (uid == null) {  
      _showDialog(context, 'Gagal', 'Pengguna tidak terautentikasi!');  
      return;  
    }  

    DocumentReference userDoc = pengguna.doc(uid);  

      return userDoc.set({  
        'uid':uid,
        'nama':nama,
        'nama_usaha': namaUsaha,  
        'alamat': alamat,  
        'nohp': phone,  
        'premium': false,  
        'status': status,  
        'email': auth.currentUser?.email, 
      }).then((value) {  
        _showDialog(context, 'Berhasil!', 'Data berhasil disimpan!');  
      }).catchError((error) {  
        _showDialog(context, 'Gagal mencatatkan data', 'Gagal menyimpan data pengguna!');  
      });  
    }  

   Stream<List<PenggunaM>> Tampilpengguna() {  
      String? uid = auth.currentUser?.uid;  

      if (uid == null) {  
        return Stream.empty(); // Mengembalikan stream kosong jika uid tidak tersedia  
      }  

      // Mengambil data berdasarkan UID  
      return FirebaseFirestore.instance  
      .collection('pengguna')  
      .where('uid', isEqualTo: uid)  
      .snapshots()  
      .map((QuerySnapshot<Map<String, dynamic>> snapshot) {  
        return snapshot.docs.map((doc) => PenggunaM.fromFirestore(doc)).toList();  
      });    
    }


  void _showDialog(BuildContext context, String status, String textstatus) {  
    showDialog(  
      context: context,  
      builder: (BuildContext context) {  
        return AlertDialog(  
          title: Text(status),  
          content: Text(textstatus),  
          actions: [  
            TextButton(  
              child: Text('OK'),  
              onPressed: () {  
                Navigator.push(  
                  context,  
                  MaterialPageRoute(builder: (context) => Bottombar(initialIndex: 0,)),  
                );  
              },  
            ),  
          ],  
        );  
      },  
    );  
  }  
}