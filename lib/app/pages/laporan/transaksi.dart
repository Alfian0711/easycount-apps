import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../widgets/dataWidget.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({super.key});

  @override
  State<Transaksi> createState() => _TransaksiState();

}
class _TransaksiState extends State<Transaksi> {
  String searchQuery = ''; // Menyimpan input pencarian

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        )
      ),
      body: 
       Column(
      children: [
           Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromRGBO(68, 68, 68, 1)
                  : Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.date_range_sharp, size: 30),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                  },
                  child: Text(
                    'Hari ini',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                Text(DateFormat('dd MMM yyyy').format(DateTime.now())),
              ],
            ),
          ),
          SizedBox(height: 6,),
          TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase(); // Memperbarui nilai pencarian
              });
            },
            decoration: InputDecoration(
              labelText: 'Cari Transaksi',
              labelStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[200]
                    : Color.fromRGBO(68, 68, 68, 1),
              ),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.dark
                  ? Color.fromRGBO(68, 68, 68, 1)
                  : Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 8,),

          // Wrap DataWidget inside an Expanded widget to make it scrollable
          Expanded(
            child: SingleChildScrollView(
              child: DataWidget(searchQuery: searchQuery,),
            ),
          ),
      ],
    )
    );
    }
}