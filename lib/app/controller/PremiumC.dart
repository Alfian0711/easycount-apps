import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/model_premium.dart';
import '../services/payment_service.dart';

class PremiumC {  
  FirebaseAuth auth = FirebaseAuth.instance;  
  CollectionReference premium = FirebaseFirestore.instance.collection('transaksi_premium');  

  // static String? _paymentUrl;  

  void onPaymentSuccess(String url, BuildContext context) {  
    ScaffoldMessenger.of(context).showSnackBar(  
      SnackBar(content: Text('Pembayaran berhasil!')),  
    );  

    final uri = Uri.parse(url);  
    final idOrder = uri.queryParameters['order_id'];  
    print('id_ord :$idOrder');  

    String? uid = auth.currentUser?.uid;  
    if (uid != null) {  
      PremiumM premiumM = PremiumM(  
        orderID: idOrder,  
        userID: uid,  
        isPremium: true,  
        premiumStartDate: DateTime.now(),  
        premiumEndDate: DateTime.now().add(const Duration(days: 30)), // Misalnya 30 hari untuk langganan premium  
      );  
      addPremiumUser(premiumM);  
    } else {  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(content: Text('Pengguna tidak ditemukan!')),  
      );  
    }  

    Navigator.pop(context, {'status': 'success'});  
  }  

  Future<void> onPaymentPending(String url, BuildContext context) async {  
    ScaffoldMessenger.of(context).showSnackBar(  
      SnackBar(content: Text('Pembayaran Belum dilunaskan!')),  
    );  

    final uri = Uri.parse(url);  
    final idOrder = uri.queryParameters['order_id'];  

    // Panggil fungsi checkTransaction untuk memeriksa status transaksi  
    final transactionData = await MidtransService().checkTransaction(idOrder);  
    if (transactionData != null) {  
      final vaNumber = transactionData['va_numbers'] != null && transactionData['va_numbers'].isNotEmpty  
          ? transactionData['va_numbers'][0]['va_number']  
          : null;  
      final bank = transactionData['va_numbers'] != null && transactionData['va_numbers'].isNotEmpty  
          ? transactionData['va_numbers'][0]['bank']  
          : null;  
      final paymentType = transactionData['payment_type'];  
      Navigator.pop(context, {  
        'status': 'pending',  
        'virtualAccount': vaNumber,  
        'bank': bank,  
        'payment_type': paymentType,
        'url':url 
      });  
    } else {  
      Navigator.pop(context, {'status': 'failed'});  
    }  
  }  

  void onPaymentFailed(BuildContext context) {  
    ScaffoldMessenger.of(context).showSnackBar(  
      SnackBar(content: Text('Pembayaran gagal.')),  
    );  
    Navigator.pop(context, {'status': 'failed'});  
  }  

  Future<void> addPremiumUser(PremiumM premiumM) async {  
    try {  
      // Menambahkan data premium ke Firestore  
      await FirebaseFirestore.instance.collection('transaksi_premium').add(premiumM.toMap());  
      print("Premium subscription saved successfully.");  
    } catch (e) {  
      print("Error saving premium subscription: $e");  
      rethrow;  
    }  
  }  

  Stream<List<PremiumM>> getPremiumData() {  
    String? uid = auth.currentUser?.uid;  

    if (uid == null) {  
      return Stream.empty();  
    }  

    // Fetch data based on UID  
    return FirebaseFirestore.instance  
        .collection('transaksi_premium')  
        .where('userID', isEqualTo: uid)  
        .snapshots()  
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {  
      return snapshot.docs.map((doc) => PremiumM.fromFirestore(doc)).toList();  
    });  
  }  

  // Future<Map<String, dynamic>?> checkPaymentStatus() async {  
  //   if (_paymentUrl == null) {  
  //     return null;  
  //   }  

  //   final uri = Uri.parse(_paymentUrl!);  
  //   final idOrder = uri.queryParameters['order_id'];  

  //   final transactionData = await MidtransService().checkTransaction(idOrder);  
  //   if (transactionData != null) {  
  //     final status = transactionData['status_code'];  
  //     if (status == 200) {  
  //       print('Payment status: $status');  
  //       return transactionData;  
  //     }  
  //   }  

  //   return null;  
  // }  

  Future<bool> checkPremiumStatus() async {  
    String? uid = auth.currentUser?.uid;  

    if (uid == null) return false;  

    DocumentSnapshot userDoc = await premium.doc(uid).get();  

    if (userDoc.exists) {  
      DateTime premiumEndDate = (userDoc['premiumEndDate'] as Timestamp).toDate();  
      return DateTime.now().isBefore(premiumEndDate);  
    }  

    return false;  
  }  

  
}