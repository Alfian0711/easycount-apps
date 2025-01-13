// import 'package:cloud_firestore/cloud_firestore.dart';

// class Model_auth {  
//   String email;
//   String uid;
//   Model_auth({required this.email, required this.uid});

//   factory Model_auth.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {  
//     final data = doc.data()!;  
//     return Model_auth(  
//       email: data['email'] ?? '',  
//       uid: data['nohp'] ?? '', 
//     );  
//   }  
// }