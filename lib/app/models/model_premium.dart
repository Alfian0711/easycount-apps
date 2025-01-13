import 'package:cloud_firestore/cloud_firestore.dart';

class PremiumM {
  final orderID;
  String userID;
  bool isPremium;
  DateTime premiumStartDate;
  DateTime premiumEndDate;

  PremiumM({
    required this.orderID,
    required this.userID,
    required this.isPremium,
    required this.premiumStartDate,
    required this.premiumEndDate,
  });

  // Convert Firestore document to PremiumM object
  factory PremiumM.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Missing data for PremiumM');
    }
    return PremiumM(  
      orderID: data['orderID'],
      userID: data['userID'],
      isPremium: data['isPremium'],
      premiumStartDate: (data['premiumStartDate'] as Timestamp).toDate(),
      premiumEndDate: (data['premiumEndDate'] as Timestamp).toDate(),
    );  
  }

    // Convert PremiumM object to map for Firestore
    Map<String, dynamic> toMap() {
      return {
        'orderID': orderID,
        'userID': userID,
        'isPremium': isPremium,
        'premiumStartDate': premiumStartDate,
        'premiumEndDate': premiumEndDate,
      };
    }
}