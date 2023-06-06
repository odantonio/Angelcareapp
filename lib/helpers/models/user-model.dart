//import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

//classe de usuário e dados requeridos
class UserModel {
  late String? id;
  late String? fullName;
  late String? type;
  late String? gender;
  late String? documentType;
  late String? documentNumber;
  late Timestamp? birthDate;
  late int age;
  late String? phoneNumber;
  late String? country;
  late String? state;
  late String? city;
  late String? cep;
  late String? image;
  late String? mainAddress;
  late String? complAddress;

  UserModel({
    this.id,
    this.type,
    this.fullName,
    this.gender,
    this.documentType,
    this.documentNumber,
    this.birthDate,
    this.age = 0,
    this.phoneNumber,
    this.state,
    this.country,
    this.city,
    this.cep,
    this.image,
    this.mainAddress,
    this.complAddress,
  });

  //Conversão dos dados para envio e recuperação do banco de dados
  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final birthDateAtTimestamp = data?['birthDate'] as Timestamp?;
    final birthDate = birthDateAtTimestamp?.toDate();
    return UserModel(
      id: data?['id'],
      type: data?['type'],
      fullName: data?['name'],
      phoneNumber: data?['phoneNumber'],
      gender: data?['gender'],
      documentType: data?['documentType'],
      documentNumber: data?['documentNumber'],
      birthDate: data?['birthDate'],
      age: data?['age'],
      country: data?['country'],
      state: data?['state'],
      city: data?['city'],
      cep: data?['cep'],
      image: data?['image'],
      mainAddress: data?['mainAddress'],
      complAddress: data?['complAddress'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (fullName != null) "name": fullName,
      if (type != null) "type": type,
      if (documentType != null) "documentType": documentType,
      if (documentNumber != null) "documentNumber": documentNumber,
      if (gender != null) "gender": gender,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (birthDate != null) "birthDate": birthDate,
      if (age != null) "age": age,
      if (state != null) "state": state,
      if (country != null) "country": country,
      if (city != null) "city": city,
      if (cep != null) "cep": cep,
      if (mainAddress != null) "mainAddress": mainAddress,
      "complAddress": complAddress,
      "image": image,
    };
  }

  @override
  String toString() {
    return 'FormData('
        'id: $id, '
        'type: $type, '
        'fullName: $fullName, '
        'phoneNumber: $phoneNumber, '
        'mainAddress: $mainAddress, '
        'complAddress: $complAddress, '
        'city: $city, '
        'state: $state, '
        'country: $country, '
        'cep: $cep, '
        'gender: $gender, '
        'documentType: $documentType, '
        'documentNumber: $documentNumber, '
        'age: $age, '
        'birthDate: $birthDate, '
        'image: $image'
        ')';
  }
}
