import 'package:easycount/app/controller/TransaksiC.dart';
import 'package:easycount/app/widgets/jenisAkun.dart';
import 'package:flutter/material.dart';  
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../widgets/jenisTransaksi.dart';  

class AddTransaksi extends StatefulWidget {  
  const AddTransaksi({super.key});  
  @override
  State<AddTransaksi> createState() => _AddTransaksiState();
}
class _AddTransaksiState extends State<AddTransaksi> {
  // import class transaksiC
  final TransaksiC Tcontroller = TransaksiC();

  final ocean = Color.fromRGBO(89, 119, 181, 1);
  DateTime ? selectedDate;
  TimeOfDay ? selectedTime;
  String ? _selectedJenisTransaksi =  null;
  String ? selectedJenisAkun_kredit;
  String ? selectedJenisAkun_debit;
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  // mengubah inputan nominal agar ada Rp. 
  String get formattedNominal {
    if (nominalController.text.isEmpty) return 'Rp. 0';
    // Parse input to number, handle invalid input safely
    try {
      int value = int.parse(nominalController.text.replaceAll('.', ''));
      return 'Rp. ${NumberFormat('#,##0', 'id_ID').format(value)}';
    } catch (e) {
      return 'Rp. 0';
    }
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
          'Tambah Transaksi',  
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
                                initialDate: selectedDate ?? DateTime.now(),  
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

              // jenis pengeluaran
              SizedBox(height: 10,),  
              DropdownJenisTransaksi(  
                selectedJenisTransaksi: (String jenisTransaksi) {  
                  setState(() {  
                    _selectedJenisTransaksi = jenisTransaksi;   
                  });  
                },  
              ),
              SizedBox(height: 10,),

              //jenis akun
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

              SizedBox(height: 10,),

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
                            labelText: formattedNominal,  
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
                      selectedJenisAkun_debit==null||
                      selectedJenisAkun_kredit==null|| 
                      selectedTime == null) {  
                    ScaffoldMessenger.of(context).showSnackBar(  
                      SnackBar(  
                        content: Text('Mohon isi semua input yang diperlukan'),  
                      ),  
                    );  
                    return;  
                  } 
                  int nominal = int.tryParse(nominalController.text) ?? 0; 
                  Tcontroller.Aksi_tambah(
                    catatan: catatanController.text,
                    nominal: nominal,
                    selectedDate:selectedDate ?? DateTime.now(),
                    selectedJenisTransaksi: _selectedJenisTransaksi.toString(),
                    selected_debit: selectedJenisAkun_debit,
                    selected_kredit: selectedJenisAkun_kredit,
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