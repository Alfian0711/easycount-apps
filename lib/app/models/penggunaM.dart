import 'package:cloud_firestore/cloud_firestore.dart';

class PenggunaM {  
  final String email;  
  final String uid;  
  final String name;  
  final String name_bussiness;
  final bool premium;  
  final String phone;  
  final String company;  
  final String address;  

  PenggunaM({  
    required this.uid,  
    required this.email,  
    required this.phone,  
    required this.company,  
    required this.address,  
    required this.name,
    required this.name_bussiness,
    required this.premium
  });  

  factory PenggunaM.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {  
    final data = doc.data()!;  
    return PenggunaM(  
      uid: data['uid'] ?? '',  
      email: data['email'] ?? '',  
      phone: data['nohp'] ?? '',  
      company: data['nama_usaha'] ?? '',  
      address: data['alamat'] ?? '',  
      name: data['nama'] ?? '',  
      name_bussiness: data['nama_usaha'] ?? '',  
      premium: data['premium'] ?? false,  
    );  
  }  

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nohp': phone,
      'nama_usaha': company,
      'alamat': address,
      'nama': name,
      'premium': premium,
    };
  }
}