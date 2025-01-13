import 'package:easycount/app/controller/ProfileC.dart';
import 'package:easycount/app/pages/tambah_transaksi_view.dart';
import 'package:easycount/app/widgets/dataWidget.dart';
import 'package:flutter/material.dart';  
import 'package:google_fonts/google_fonts.dart';  
import 'package:intl/intl.dart';

class Home extends StatefulWidget {  
 Home({super.key});  

  @override  
  State<Home> createState() => _HomeState();  
}  
  class _HomeState extends State<Home> {
  bool data = false; // Ubah nilai awal menjadi false   
  final ocean = Color.fromRGBO(89, 119, 181, 1);
  String searchQuery = ''; // Menyimpan input pencarian


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: 5,),

          Container(
            margin: EdgeInsets.all(15),
            child: StreamBuilder(
              stream: ProfileC().Tampilpengguna(), 
              builder: (context, snapshot){
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
                final users = snapshot.data ?? [];  

                return Row(
                  children: [
                    CircleAvatar(
                      child: Image.asset(
                        'assets/logo/logo.png',
                        width: 100,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(users.first.company, style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                          )
                        ),),
                        Text(users.first.address,style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold)
                          )
                        )
                      ],
                    )
                  ],
                );
              }
            ),
          ),
          SizedBox(height: 10,),
          // DATE CONTAINER
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
                Spacer(),
                // DATE TEXT
                TextButton(
                  onPressed: () {
                    // Add your PDF functionality here
                  },
                  child: Text(
                    'PDF',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Add your Excel functionality here
                  },
                  child: Text(
                    'Excel',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
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
              child: DataWidget(searchQuery: searchQuery),
            ),
          ),
          // Center(
          //   child:DataWidget()
          // ),
          // Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
              backgroundColor: ocean,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(13),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTransaksi()),
              );
            },
            child: Text(
              'Tambah Transaksi',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Bottombar(),
    );
  }  
} 