//import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

//classe de monitoredos e dados requeridos
class MonitoredModel {
  late String id;
  late String name;
  late String cpf;
  late String email;
  late int? time;
  late String phoneNumber;
  late String? image;

  MonitoredModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.image,
  });

  //Conversão dos dados para envio e recuperação do banco de dados
  factory MonitoredModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MonitoredModel(
      id: data?['id'],
      name: data?['name'],
      email: data?['email'],
      phoneNumber: data?['phoneNumber'],
      image: data?['image'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      "image": image,
    };
  }
}
