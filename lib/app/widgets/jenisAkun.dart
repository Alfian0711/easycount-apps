import 'package:flutter/material.dart';  
import 'package:google_fonts/google_fonts.dart';  

class JenisAkun extends StatefulWidget {  
  final Function(String) selectedJenisAkun_debit;  
  final Function(String) selectedJenisAkun_kredit;  
  final String? selectedJenisTransaksi;  

  JenisAkun({
    required this.selectedJenisAkun_debit, 
    required this.selectedJenisAkun_kredit, 
    required this.selectedJenisTransaksi,
  });  

  @override  
  State<JenisAkun> createState() => _JenisAkunState();  
}  

class _JenisAkunState extends State<JenisAkun> {  
  String? selectedJenisAkun_debit;  
  String? selectedJenisAkun_kredit;  

  // Data opsi dropdown
  final List<Map<String, dynamic>> jenisAkun_debit = [  
    {'id': '1-001', 'nama_akun': 'Kas'},  
    {'id': '1-002', 'nama_akun': 'Rekening Bank'},  
  ];  
  final List<Map<String, dynamic>> jenisAkun_kredit = [  
    {'id': '2-001', 'nama_akun': 'Pendapatan'},  
    {'id': '2-002', 'nama_akun': 'Diskon penjualan'},  
    {'id': '2-003', 'nama_akun': 'Pengembalian penjualan'},  
  ];  
  final List<Map<String, dynamic>> jenisPengeluaran_debit = [  
    {'id': '6-001', 'nama_akun': 'Beban Pokok pendapatan'},  
    {'id': '6-002', 'nama_akun': 'Biaya Produksi'},  
    {'id': '6-003', 'nama_akun': 'Iklan & Promosi'},  
    {'id': '6-004', 'nama_akun': 'Upah'},  
  ];  
  final List<Map<String, dynamic>> jenisPengeluaran_kredit = [  
    {'id': '1-001', 'nama_akun': 'Kas'},  
    {'id': '1-002', 'nama_akun': 'Rekening Bank'},  
  ];  
  final List<Map<String, dynamic>> jenis_kreditModal = [  
    {'id': '3-001', 'nama_akun': 'Saldo Awal'},  
    {'id': '3-002', 'nama_akun': 'Modal Tambahan'},  
  ];  

  void resetSelectionsIfNeeded(
      List<Map<String, dynamic>> isidropdown_Debit,
      List<Map<String, dynamic>> isidropdown_Kredit) {
    setState(() {
      // Reset selected debit if not in new options
      if (selectedJenisAkun_debit != null &&
          !isidropdown_Debit.any((item) => item['id'] == selectedJenisAkun_debit)) {
        selectedJenisAkun_debit = null;
      }
      // Reset selected kredit if not in new options
      if (selectedJenisAkun_kredit != null &&
          !isidropdown_Kredit.any((item) => item['id'] == selectedJenisAkun_kredit)) {
        selectedJenisAkun_kredit = null;
      }
    });
  }

  @override  
  Widget build(BuildContext context) {  
    List<Map<String, dynamic>>? isidropdown_Debit;
    List<Map<String, dynamic>>? isidropdown_Kredit;
    var jenisTransaksi = widget.selectedJenisTransaksi;

    // Pilih dropdown berdasarkan jenis transaksi
    if (jenisTransaksi == 'Pemasukan') {  
      isidropdown_Debit = jenisAkun_debit;  
      isidropdown_Kredit = jenisAkun_kredit;  
    } else if(jenisTransaksi == 'Tanam Modal') {  
      isidropdown_Debit = jenisAkun_debit;  
      isidropdown_Kredit = jenis_kreditModal;  
    } else{
      isidropdown_Debit = jenisPengeluaran_debit;  
      isidropdown_Kredit = jenisPengeluaran_kredit;
    }

    // Reset pilihan jika perlu
    resetSelectionsIfNeeded(isidropdown_Debit, isidropdown_Kredit);

    return Column(  
      crossAxisAlignment: CrossAxisAlignment.start,  
      children: [  
        ExpansionTile(  
          collapsedBackgroundColor: Theme.of(context).brightness == Brightness.dark  
              ? Color.fromRGBO(68, 68, 68, 1)  
              : Colors.white,  
          backgroundColor: Theme.of(context).brightness == Brightness.dark  
              ? Color.fromRGBO(68, 68, 68, 1)  
              : Colors.white,  
          title: Text('Debit'),  
          children: [  
            Container(  
              margin: EdgeInsets.only(left: 20, right: 20,bottom: 20),  
              padding: EdgeInsets.all(8),  
              width: double.infinity,  
              decoration: BoxDecoration(  
                border: Border.all(  
                  color: Colors.grey[400]!,  
                  width: 1.0,  
                ),  
                borderRadius: BorderRadius.circular(13),  
              ),  
              child: DropdownButtonHideUnderline(  
                child: DropdownButton<String>(  
                  value: selectedJenisAkun_debit,  
                  hint: Padding(  
                    padding: EdgeInsets.all(10),  
                    child: Text('Jenis Akun',  
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
                      selectedJenisAkun_debit = newValue;  
                    });  
                    if (newValue != null) {  
                      widget.selectedJenisAkun_debit(newValue);  
                    }  
                  },  
                  items: isidropdown_Debit.map<DropdownMenuItem<String>>((Map<String, dynamic> item) {  
                    return DropdownMenuItem<String>(  
                      value: item['id'],  
                      child: Padding(  
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),  
                        child: Text(item['nama_akun']),  
                      ),  
                    );  
                  }).toList(),  
                ),  
              ),  
            ),  
          ],  
        ),  
        ExpansionTile(  
          collapsedBackgroundColor: Theme.of(context).brightness == Brightness.dark  
              ? Color.fromRGBO(68, 68, 68, 1)  
              : Colors.white,  
          backgroundColor: Theme.of(context).brightness == Brightness.dark  
              ? Color.fromRGBO(68, 68, 68, 1)  
              : Colors.white,  
          title: Text('Kredit'),  
          children: [  
            Container(  
              margin: EdgeInsets.only(left: 20, right: 20,bottom: 20),  
              padding: EdgeInsets.all(8),  
              width: double.infinity,  
              decoration: BoxDecoration(  
                border: Border.all(  
                  color: Colors.grey[400]!,  
                  width: 1.0,  
                ),  
                borderRadius: BorderRadius.circular(13),  
              ),  
              child: DropdownButtonHideUnderline(  
                child: DropdownButton<String>(  
                  value: selectedJenisAkun_kredit,  
                  hint: Padding(  
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),  
                    child: Text('Jenis Akun',  
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
                      selectedJenisAkun_kredit = newValue;  
                    });  
                    if (newValue != null) {  
                      widget.selectedJenisAkun_kredit(newValue);  
                    }  
                  },  
                  items: isidropdown_Kredit.map<DropdownMenuItem<String>>((Map<String, dynamic> item) {  
                    return DropdownMenuItem<String>(  
                      value: item['id'],  
                      child: Padding(  
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),  
                        child: Text(item['nama_akun']),  
                      ),  
                    );  
                  }).toList(),  
                ),  
              ),  
            ),  
          ],  
        ),  
      ],  
    );  
  }  
}
