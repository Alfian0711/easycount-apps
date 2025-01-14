import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easycount/app/pages/auth/identity.dart';
import 'package:easycount/app/pages/intro.dart';
import 'package:easycount/app/widgets/bottomBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/auth/loginview.dart';

class AuthC {
  
Future<void> Signup({  
  required String email,  
  required String password,  
  required BuildContext context,  
}) async {  
  try {  
    // Buat pengguna baru dengan email dan password  
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(  
      email: email,  
      password: password,  
    );  

    User? user = credential.user;  

    if (user != null) {  
      // Kirim verifikasi email setelah pengguna berhasil dibuat  
      await user.sendEmailVerification();  

      // Menambahkan pengguna ke Firestore  
      await FirebaseFirestore.instance.collection('pengguna').doc(user.uid).set({  
        'uid': user.uid,  
        'email': email,  
      });  

      // Navigasi ke halaman login setelah signup berhasil  
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login())); 
      showErrorDialog(context, 'Berhasil Daftar', 'User berhasil dibuat'); 
      // print('User signed up: ${user.email}');  
    } else {  
      print('Gagal input user');  
    }  
    
  } on FirebaseAuthException catch (e) {  
    if (e.code == 'weak-password') {  
      showErrorDialog(context, 'Gagal Regist', 'Password lemah');
      print('The password provided is too weak.');  
    } else if (e.code == 'email-already-in-use') {  
      showErrorDialog(context, 'Gagal Regist', 'Email sudah terdaftar');
      print('The account already exists for that email.');  
    } else {  
      showErrorDialog(context, 'Gagal Regist', 'Password harus lebih dari 6 karakter');
      print('Error: ${e.message}');  
    }  
  } catch (e) {  
    print('Error: $e');  
  }  
}  

 Future<void> Signin({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    // Sign in user with email and password
    UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;

    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('pengguna').doc(user.uid).get();

      if (userData.exists) {
        Map<String, dynamic>? userDataMap = userData.data() as Map<String, dynamic>?;

        if (userDataMap != null && userDataMap['nama_usaha'] != null && userDataMap['nama_usaha'].isNotEmpty) {
          // Arahkan ke halaman home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Bottombar(initialIndex: 0)),
          );
        } else {
          // Arahkan ke halaman identitas
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Identity()));
        }
      } else {
        showErrorDialog(context, 'Gagal Login', 'Data pengguna tidak ditemukan.');
      }
    }
  } on FirebaseAuthException catch (e) {
    // Tangani error login
    String errorMessage;

    if (e.code == 'user-not-found') {
      errorMessage = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      errorMessage = 'Wrong password provided for that user.';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'Email salah.';
    } else if (e.code == 'invalid-credential') {
      errorMessage = 'Email atau password salah.';
    } else {
      errorMessage = 'Masukkan email dan password.';
    }

    showErrorDialog(context, 'Gagal Login', errorMessage);
  } catch (e) {
    showErrorDialog(context, 'Gagal Login', 'Terjadi kesalahan. Silakan coba lagi.');
    print(e);
  }
}


  void showErrorDialog(BuildContext context, String headmessage,String submessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark  
                  ? Color.fromRGBO(68, 68, 68, 1)  
                  : Colors.grey[200],  
          title: Text(headmessage),
          content: Text(submessage),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

Future<void> Logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();

    // Navigate to Login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Intro()),
      (Route<dynamic> route) => false,
    );
  }
}