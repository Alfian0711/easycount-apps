import 'package:easycount/app/pages/home.dart';
import 'package:easycount/app/pages/laporan.dart';
import 'package:easycount/app/pages/premium.dart';
import 'package:easycount/app/pages/setting.dart';
import 'package:flutter/material.dart';
import '../pages/tambah_transaksi_view.dart';

class Bottombar extends StatefulWidget {
  final int initialIndex;

  const Bottombar({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  late int _selectedIndex;
  final ocean = Color.fromRGBO(89, 119, 181, 1);

  // List of pages
  final List<Widget> _pages = [
    Home(),
    Premium_View(),
    AddTransaksi(),
    Laporan(),
    Setting(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;  // Initialize with the selected index
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,  // Switch between pages based on the selected index
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage, color: Colors.white),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, color: Colors.white),
            label: 'Tambah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart, color: Colors.white),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.white),
            label: 'Pengaturan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ocean,
        onTap: _onItemTapped,
      ),
    );
  }
}
