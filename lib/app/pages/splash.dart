import 'dart:async';
import 'package:easycount/app/pages/intro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/bottomBar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () async {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Pengguna sudah login, arahkan ke halaman utama
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Bottombar(initialIndex: 0)),
        );
      } else {
        // Pengguna belum login, arahkan ke halaman intro
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Intro()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Image.asset(
          'assets/logo/logoapp.png',
          width: 150, // Sesuaikan ukuran logo
          height: 150,
        ),
      ),
    );
  }
}
