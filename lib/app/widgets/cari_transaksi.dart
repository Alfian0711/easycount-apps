import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easycount/app/controller/TransaksiC.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CariTransaksi extends StatefulWidget {
  @override
  _CariTransaksiState createState() => _CariTransaksiState();
}

class _CariTransaksiState extends State<CariTransaksi> {
  String searchQuery = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cari Transaksi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                labelText: 'Cari Transaksi',
                prefixIcon: Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: searchQuery.isEmpty
                  ? FirebaseFirestore.instance.collection('transaksi').snapshots()
                  : TransaksiC().Cari_transaksi(searchQuery),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final transaksiList = snapshot.data!.docs;
                if (transaksiList.isEmpty) {
                  return Center(child: Text('Tidak ada transaksi ditemukan.'));
                }
                return ListView.builder(
                  itemCount: transaksiList.length,
                  itemBuilder: (context, index) {
                    final transaksi =
                        transaksiList[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(transaksi['catatan']),
                      subtitle: Text(
                          'Nominal: Rp ${transaksi['nominal']} - ${DateFormat('dd MMM yyyy').format(transaksi['tgl_transaksi'].toDate())}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
