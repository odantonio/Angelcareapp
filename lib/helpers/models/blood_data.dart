import 'package:cloud_firestore/cloud_firestore.dart';

class TimeSeriesSales {
  final DateTime time;
  final int max;

  TimeSeriesSales(this.time, this.max);

  factory TimeSeriesSales.fromFirebase(Map<String, dynamic> data) {
    Timestamp timestamp = data['timestamp'];
    int value = data['valor'];

    return TimeSeriesSales(timestamp.toDate(), value);
  }
}

Future<List<TimeSeriesSales>> getDataFromFirebase() async {
  List<TimeSeriesSales> data = [];

  try {
    // Buscar os documentos na coleção "heart" ordenados pelo campo "timestamp"
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('blood')
        .orderBy('timestamp')
        .get();

    // Converter os documentos em objetos TimeSeriesSales
    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      int valor = documentSnapshot['valor'];
      Timestamp timestamp = documentSnapshot['timestamp'];

      // Converter o Timestamp para DateTime
      DateTime dateTime = timestamp.toDate();

      // Criar um objeto TimeSeriesSales e adicioná-lo à lista de dados
      TimeSeriesSales timeSeriesSales = TimeSeriesSales(dateTime, valor);
      data.add(timeSeriesSales);
    }
  } catch (error) {
    // Lidar com erros, se necessário
    print('Erro ao buscar os dados do Firebase: $error');
  }

  return data;
}
