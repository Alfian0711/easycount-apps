import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownJenisTransaksi extends StatefulWidget {  
  final Function(String) selectedJenisTransaksi;
  
  DropdownJenisTransaksi({required this.selectedJenisTransaksi});  

  @override  
  State<DropdownJenisTransaksi> createState() => _DropdownAkunState();  
}  

class _DropdownAkunState extends State<DropdownJenisTransaksi> {  
  String? selectedJenisTransaksi;  

  final List<String> jenistransaksi = [    
    'Pemasukan',  
    'Pengeluaran',  
    'Piutang',  
    'Hutang',  
    'Tanam Modal'  
  ];  

  @override  
  Widget build(BuildContext context) {  
    return Column(  
      crossAxisAlignment: CrossAxisAlignment.start,  
      children: [  
        Text('Jenis Transaksi',  
            style: GoogleFonts.plusJakartaSans(  
                textStyle: TextStyle(  
                    fontSize: 18, fontWeight: FontWeight.w600))),  
        SizedBox(height: 8),  
        Container(  
          height: 50,  
          width: double.infinity,  
          decoration: BoxDecoration(  
            color: Theme.of(context).brightness == Brightness.dark  
                ? Color.fromRGBO(68, 68, 68, 1)  
                : Colors.white,  
            borderRadius: BorderRadius.circular(13),  
             border: Border.all(  
              color: Colors.grey[400]!,  
              width: 1.0,  
            ),   
          ),  
          child: DropdownButtonHideUnderline(  
            child: DropdownButton<String>(  
              value: selectedJenisTransaksi,  
              hint: Padding(  
                padding: const EdgeInsets.symmetric(horizontal: 10.0),  
                child: Text('Pengeluaran',  
                    style: GoogleFonts.plusJakartaSans(  
                        textStyle: TextStyle(  
                      color: Theme.of(context).brightness == Brightness.dark  
                          ? Colors.white  
                          : Color.fromRGBO(68, 68, 68, 1),  
                      fontWeight: FontWeight.w500,  
                    ))),  
              ),  
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),  
              dropdownColor: Colors.grey[900],  
              style: TextStyle(color: Colors.white),  
              onChanged: (String? newValue) {  
                setState(() {  
                  selectedJenisTransaksi = newValue;  
                });  
                // Memanggil callback untuk mengirim data ke parent  
                if (newValue != null) {  
                  widget.selectedJenisTransaksi(newValue);  
                }  
              },  
              items: jenistransaksi.map<DropdownMenuItem<String>>((String value) {  
                return DropdownMenuItem<String>(  
                  value: value,  
                  child: Padding(  
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),  
                    child: Text(value),  
                  ),  
                );  
              }).toList(),  
            ),  
          ),  
        ),  
      ],  
    );  
  }  
}   