import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Introtext extends StatelessWidget {
  const Introtext({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
          Row(
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 10,
            ),
            Text(
              'Data Tersimpan di Cloud',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17,
                )
              ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 10,
            ),
            Text(
              '100% Aman dan Mudah digunakan',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17,
                )
              ),
          ],
        ),Row(
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 10,
            ),
            Text(
              'Laporan dapat di Export',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17,
                )
              ),
          ],
        ),
      ],
    );
  }
}
