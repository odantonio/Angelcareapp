import 'package:cloud_firestore/cloud_firestore.dart';

class EmergencyContact {
  late String userId;
  late String fullName;
  late String email;
  late String phoneNumber;
  EmergencyContact({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });
  factory EmergencyContact.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return EmergencyContact(
      userId: data?['name'],
      fullName: data?['state'],
      email: data?['country'],
      phoneNumber: data?['capital'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userId != null) "userId": userId,
      if (fullName != null) "fullName": fullName,
      if (email != null) "email": email,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
    };
  }
}
