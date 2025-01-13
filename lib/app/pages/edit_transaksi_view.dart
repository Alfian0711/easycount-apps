import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:easycount/app/controller/TransaksiC.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../widgets/jenisAkun.dart';
import '../widgets/jenisTransaksi.dart';  

class EditTransaksi extends StatefulWidget {  
  final Map<String, dynamic> data;
  const EditTransaksi({super.key, required this.data});  
  
  @override
  State<EditTransaksi> createState() => _EditTransaksiState();
}
class _EditTransaksiState extends State<EditTransaksi> {
  // import class transaksiC
  final TransaksiC Tcontroller = TransaksiC();

  final ocean = Color.fromRGBO(89, 119, 181, 1);
  // String id = widget.data['id'];
  DateTime ? selectedDate;
  DateTime ? dateBase;
  TimeOfDay ? selectedTime;
  String ? _selectedJenisTransaksi = null;
  String ? selectedJenisAkun_kredit;
  String ? selectedJenisAkun_debit;
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  @override  
void initState() {  
  super.initState();  
  nominalController.text = widget.data['nominal'].toString();  
  catatanController.text = widget.data['catatan'];  
  dateBase = (widget.data['tgl_transaksi'] as Timestamp).toDate();  
  _selectedJenisTransaksi = widget.data['jenisTransaksi'];  
  // Konversi data lainnya sesuai kebutuhan  
}

  @override
  // fungsi cleaning data texteditingcontroller
  void dispose() {  
    nominalController.dispose();  
    catatanController.dispose();  
    super.dispose();  
  }     
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: Text(  
          'Ubah Transaksi',  
          style: GoogleFonts.poppins(  
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),  
          ),  
        ),  
      ),  
      body: SingleChildScrollView(  
        child: Container(  
          margin: EdgeInsets.all(13),  
          child: Column(  
            children: [  
              SizedBox(height: 20,),  
              Row(  
                crossAxisAlignment: CrossAxisAlignment.start,   
                children: [  
                  Expanded(  
                    child: Column(  
                      crossAxisAlignment: CrossAxisAlignment.start,  
                      children: [  
                        Text('Tanggal',  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontWeight: FontWeight.w600,  
                              fontSize: 18  
                            )  
                          )),  
                        SizedBox(height: 8),  
                        Container(  
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.all(15),
                                side: BorderSide(
                                  color:  Theme.of(context).brightness == Brightness.dark  
                                ? Colors.white  
                                : Color.fromRGBO(68, 68, 68, 1),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width),
                                backgroundColor: Theme.of(context).brightness == Brightness.dark  
                                ? Color.fromRGBO(68, 68, 68, 1)  
                                : Colors.white,  
                              ),
                              onPressed: () async{
                              DateTime ? pickedDate = await showDatePicker(  
                                context: context,  
                                initialDate: selectedDate ?? dateBase,  
                                firstDate: DateTime(2000),  
                                lastDate: DateTime(2030),  
                              );  
                               if (pickedDate != null && pickedDate != selectedDate) {  
                                setState(() {  
                                  selectedDate = pickedDate; // Simpan tanggal yang dipilih  
                                });  
                              }
                            }, 
                            child: Text(
                              selectedDate != null  
                                ? DateFormat('dd MMM yyyy').format(selectedDate!)  
                                : DateFormat('dd MMM yyyy').format(DateTime.now()),
                            style: GoogleFonts.plusJakartaSans(
                              textStyle: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).brightness == Brightness.dark  
                                ? Colors.white  
                                : Color.fromRGBO(68, 68, 68, 1),
                                fontWeight: FontWeight.w600
                              )
                            ),
                            )
                          ),
                        ),  
                      ],  
                    ),  
                  ),  
                  SizedBox(width: 10),   
                  Expanded(  
                    child: Column(  
                      crossAxisAlignment: CrossAxisAlignment.start,  
                      children: [  
                        Text('Waktu',  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontWeight: FontWeight.w600,  
                              fontSize: 18  
                            )  
                          )),    
                        SizedBox(height: 8),  
                        Container(  
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Theme.of(context).brightness == Brightness.dark  
                                ? Colors.white  
                                : Color.fromRGBO(68, 68, 68, 1),
                                ),
                                padding: EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width),
                                backgroundColor: Theme.of(context).brightness == Brightness.dark  
                                ? Color.fromRGBO(68, 68, 68, 1)  
                                : Colors.white,  
                              ),
                              onPressed: () async{
                              TimeOfDay ? pickedTime = await showTimePicker(  
                                context: context,  
                                initialTime: selectedTime ?? TimeOfDay.now(),
                              );

                              if (pickedTime != null && pickedTime != selectedDate) {  
                                setState(() {  
                                  selectedTime = pickedTime; // Simpan waktu yang dipilih  
                                });  
                              }

                            }, 
                            child: Text(
                              selectedTime != null
                              ? selectedTime!.format(context)
                              : TimeOfDay.now().format(context),
                            style: GoogleFonts.plusJakartaSans(
                              textStyle: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).brightness == Brightness.dark  
                                ? Colors.white  
                                : Color.fromRGBO(68, 68, 68, 1),
                                fontWeight: FontWeight.w600
                              )
                            ),
                            )
                          ),
                        ),  
                      ],  
                    ),  
                  ),  
                ],  
              ),  

              SizedBox(height: 10,),  
              DropdownJenisTransaksi(  
                selectedJenisTransaksi: (String jenisTransaksi) {  
                  setState(() {  
                    _selectedJenisTransaksi = jenisTransaksi;   
                  });  
                },  
              ),
              SizedBox(height: 10,),

              JenisAkun(  
             selectedJenisTransaksi: _selectedJenisTransaksi,            
              selectedJenisAkun_debit: (String jenisAkun_debit) {  
                setState(() {  
                  selectedJenisAkun_debit = jenisAkun_debit;  
                });  
              },  
              selectedJenisAkun_kredit: (String jenisAkun_kredit) {  
                setState(() {  
                  selectedJenisAkun_kredit = jenisAkun_kredit;  
                });  
              },  


            ),

              // input nomial
                  Column(  
                      crossAxisAlignment: CrossAxisAlignment.start,  
                      children: [  
                        Text('Nominal',  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontWeight: FontWeight.w600,  
                              fontSize: 18  
                            )  
                          )),  
                        SizedBox(height: 8),  
                        TextField(  
                          controller: nominalController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(  
                            labelText: 'Rp.0',  
                            filled: true,  
                            fillColor: Theme.of(context).brightness == Brightness.dark  
                                ? Color.fromRGBO(68, 68, 68, 1)  
                                : Colors.white,  
                            border: OutlineInputBorder(  
                              borderRadius: BorderRadius.circular(13),  
                            ),  
                            focusedBorder: OutlineInputBorder(  
                              borderRadius: BorderRadius.circular(13),  
                              borderSide: BorderSide(color: Colors.white),  
                            ),  
                          ),  
                        ),  
                      ],  
                    ),  

              // input catatan
                  SizedBox(height: 15),
                    Column(  
                      crossAxisAlignment: CrossAxisAlignment.start,  
                      children: [  
                        Text('Catatan',  
                          style: GoogleFonts.plusJakartaSans(  
                            textStyle: TextStyle(  
                              fontWeight: FontWeight.w600,  
                              fontSize: 18  
                            )  
                          )),  
                        SizedBox(height: 8),  
                        TextField(  
                          controller: catatanController,
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(  
                            contentPadding: EdgeInsets.all(20),
                            labelText: 'Masukkan Catatan',  
                            filled: true,  
                            fillColor: Theme.of(context).brightness == Brightness.dark  
                                ? Color.fromRGBO(68, 68, 68, 1)  
                                : Colors.white,  
                            border: OutlineInputBorder(  
                              borderRadius: BorderRadius.circular(13),  
                            ),  
                            focusedBorder: OutlineInputBorder(  
                              borderRadius: BorderRadius.circular(13),  
                              borderSide: BorderSide(color: Colors.white),  
                            ),  
                          ),  
                        ),  
                      ],  
                    ),  

                    SizedBox(height: 30,),

              ElevatedButton(
                style: 
                ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(MediaQuery.of(context).size.width),
                  backgroundColor: ocean,
                shape: 
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.all(13),
                ),
                onPressed: () {
                  
                  if (nominalController.text.isEmpty ||  
                      catatanController.text.isEmpty ||  
                      selectedDate == null ||  
                      _selectedJenisTransaksi == null ||  
                      selectedTime == null) {  
                    // Tampilkan pesan error jika ada input yang kosong  
                    ScaffoldMessenger.of(context).showSnackBar(  
                      SnackBar(  
                        content: Text('Mohon isi semua input yang diperlukan'),  
                      ),  
                    );  
                    return;  
                  } 

                  int nominal = int.tryParse(nominalController.text) ?? 0; // Konversi string ke int  
                  Tcontroller.Aksi_ubah(
                    documentId: widget.data['id'],
                    catatan: catatanController.text,
                    nominal: nominal,
                    selected_debit: selectedJenisAkun_debit,
                    selected_kredit: selectedJenisAkun_kredit,
                    selectedDate:selectedDate ?? DateTime.now(),
                    selectedJenisTransaksi: _selectedJenisTransaksi.toString(),
                    selectedTime: selectedTime ?? TimeOfDay.now(),
                    context: context
                  );

                  setState(() {  
                  selectedDate = null;  
                  selectedTime = null;  
                  _selectedJenisTransaksi = null;  
                  nominalController.clear();  
                  catatanController.clear();  
                }); 
                },
                child: Text('Simpan', 
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                  ),
                ),
              ),
            ],  
          ),  
        ),  
      ),  
    );  
  }  
}  