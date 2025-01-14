import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class MidtransService {
  final String serverKey = 'SERVER_KEY';
  final String baseUrl =
      'https://app.sandbox.midtrans.com/snap/v1/transactions';

  Future<Map<String, dynamic>> createTransaction(
      int amount, String nama, String namaBisnis, String email, String nohp, String uid) async {
    if (amount <= 0) {
      throw Exception("Amount must be greater than 0");
    }
    if (nama.isEmpty || email.isEmpty || nohp.isEmpty) {
      throw Exception("All fields are required");
    }

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Basic ' + base64Encode(utf8.encode('$serverKey:'))
    };

    final uuid = Uuid();
    final orderId = uuid.v4();

    final body = {
      "transaction_details": {
        "order_id": "Premium-$orderId",
        "gross_amount": amount
      },
      "credit_card": {"secure": true},
      "customer_details": {
        "first_name": nama,
        "last_name": namaBisnis,
        "email": email,
        "phone": nohp
      },
      // "enabled_payments": ["bank_transfer", "credit_card", "gopay"],
      // "bank_transfer": {
      //   "bank": "bca" // Atau Anda bisa menambahkan bank lain seperti 'bni', 'mandiri', dll.
      // }
    };

    final response = await http.post(Uri.parse(baseUrl),
        headers: headers, body: jsonEncode(body));

    if (response.statusCode == 201 || response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create transaction: ${response.body}');
    }
  }


 Future<Map<String, dynamic>?> checkTransaction(orderID) async {  
  final baseUrl_cek = 'https://api.sandbox.midtrans.com/v2/';  
  try {  
    final headers = {  
      'Authorization': 'Basic ${base64Encode(utf8.encode('$serverKey:'))}',  
      'Content-Type': 'application/json',  
    };  

    final url = Uri.parse('$baseUrl_cek/$orderID/status');  
    final response = await http.get(url, headers: headers);  

    if (response.statusCode == 200) {  
      final data = jsonDecode(response.body);  
      //  print('Parsed Data: $data');
      return data;  
    } else {  
      print('Gagal memeriksa transaksi. Kode status: ${response.statusCode}');  
      return null;  
    }  
  } catch (e) {  
    print('Error saat memeriksa transaksi: $e');  
    return null;  
  }  
}
}
