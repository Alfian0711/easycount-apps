import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controller/TransaksiC.dart';
import '../pages/detail_transaksi_view.dart';

class DataWidget extends StatelessWidget {
  final String searchQuery;
  const DataWidget({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: TransaksiC().Tampildata(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Datakosong();
        }

        // Mengubah QuerySnapshot menjadi daftar Map<String, dynamic>
        final transaksiDocs = snapshot.data!.docs;
        final transaksiList = transaksiDocs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id; 
          return data;
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: transaksiList
              .where((data) {
                final String catatan = (data['catatan'] ?? '').toLowerCase();
                final String jenisTransaksi = (data['jenisTransaksi'] ?? '').toLowerCase();
                return catatan.contains(searchQuery.toLowerCase()) ||
                    jenisTransaksi.contains(searchQuery.toLowerCase());
              })
              .map((data) {
                final String jenisTransaksi = data['jenisTransaksi'] ?? 'Unknown';
                Color borderColor =
                    jenisTransaksi == 'Pengeluaran' ? Colors.red : Colors.blue;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailTransaksi(data: data),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).brightness ==
                              Brightness.dark
                          ? const Color.fromRGBO(68, 68, 68, 1)
                          : Colors.grey[200],
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(
                        color: borderColor,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data['catatan'] ?? 'No description',
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[200]
                                    : const Color.fromRGBO(68, 68, 68, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _formatDate(data['tgl_transaksi']),
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rp. ${data['nominal'].toString()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              jenisTransaksi,
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[200]
                                    : const Color.fromRGBO(68, 68, 68, 1),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              })
              .toList(),
        );
      },
    );
  }

  String _formatDate(dynamic date) {
    if (date is Timestamp) {
      return DateFormat('dd-MM-yyyy').format(date.toDate());
    } else if (date is String) {
      try {
        return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
      } catch (_) {
        return 'Invalid Date';
      }
    }
    return 'Unknown Date';
  }
}

class Datakosong extends StatelessWidget {
  const Datakosong({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Data Kosong',
        style: GoogleFonts.poppins(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
