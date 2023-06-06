import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/*
*FormData é um mapa para armazenar os dados do formulário. Ele é idêntico ao user-model.
* A opção por criar este outro modelo foi que este precisava ter gerenciamento de estado, pois o formulário é
* um formumário multipaginas. Então os valores precisam ser mantidos. O outro não.
*
* Além disso ele usa estrutura WithConverte do firebase.
*
* A estrutura toString é apenas para usar o print no debug, ler os valores que estavam sendo passado ao banco de dados.
*
* apenas por questão de nulifiação do dart3, os valores aqui podem ser nulos. Na realidade, tirando complAddress (complemento do endereço) e imagem
* podem ser nulos, os outros valores sao requeridos. Usando o Form_Builder_Validations é garantido que o campo seja preenchido antes de passar para
* a próxima página.
*
* */
class FormData extends ChangeNotifier {
  late String? id;
  late String? type;
  late String? fullName;
  late String? phoneNumber;
  late String? mainAddress;
  late String? complAddress;
  late String? city;
  late String? state;
  late String? country;
  late String? cep;
  late String? gender;
  late String? documentType;
  late String? documentNumber;
  late int? age;
  late Timestamp? birthDate;
  late String? image;

  FormData({
    this.id,
    this.type,
    this.fullName,
    this.gender,
    this.documentType,
    this.documentNumber,
    this.birthDate,
    this.phoneNumber,
    this.state,
    this.country,
    this.city,
    this.cep,
    this.image,
    this.mainAddress,
    this.complAddress,
    this.age,
  });

  //Conversão dos dados para envio e recuperação do banco de dados
  factory FormData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final birthDateAtTimestamp = data?['birthDate'] as Timestamp?;
    final birthDate = birthDateAtTimestamp?.toDate();
    return FormData(
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

  /*
  * estas funcões apenas passam os valores entrados pelo usuário aos listeners, assim os campos mantém os dados até o momento de enviar.
  * */
  void updateId(String value) {
    id = value;
    notifyListeners();
  }

  void updateName(String value) {
    fullName = value;
    notifyListeners();
  }

  void updateType(String value) {
    type = value;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void updateGender(String value) {
    gender = value;
    notifyListeners();
  }

  void updateDocumentType(String value) {
    documentType = value;
    notifyListeners();
  }

  void updateDocumentNumber(String value) {
    documentNumber = value;
    notifyListeners();
  }

  void updateAge(int value) {
    age = value;
    notifyListeners();
  }

  void updateBirthDate(Timestamp value) {
    birthDate = value;
    notifyListeners();
  }

  void updateMainAddress(String value) {
    mainAddress = value;
    notifyListeners();
  }

  void updateComplAddress(String value) {
    complAddress = value;
    notifyListeners();
  }

  void updateCountry(String value) {
    country = value;
    notifyListeners();
  }

  void updateState(String value) {
    state = value;
    notifyListeners();
  }

  void updateCity(String value) {
    city = value;
    notifyListeners();
  }

  void updateCep(String value) {
    cep = value;
    notifyListeners();
  }

  void updateImage(String value) {
    image = value;
    notifyListeners();
  }
}
