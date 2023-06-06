import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/emergency-contacts.dart';

class MonitoredStatistics {
  String id;
  DateTime date;
  String heartFrequency;
  String oxygenation;
  String temperature;
  String bloodPressure;
  // EmergencyContact emergencyContacts;

  MonitoredStatistics({
    required this.id,
    required this.date,
    required this.heartFrequency,
    required this.oxygenation,
    required this.temperature,
    required this.bloodPressure,
    //required this.emergencyContacts,
  });

  factory MonitoredStatistics.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MonitoredStatistics(
      id: data!['id'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      heartFrequency: data['heartFrequency'],
      oxygenation: data['oxygenation'],
      temperature: data['temperature'],
      bloodPressure: data['bloodPressure'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'date': DateTime.fromMillisecondsSinceEpoch(date as int),
      'heartFrequency': heartFrequency,
      'oxygenation': oxygenation,
      'temperature': temperature,
      'bloodPressure': bloodPressure,
      //'emergencyContacts': emergencyContacts.toFirestore(),
    };
  }
}
