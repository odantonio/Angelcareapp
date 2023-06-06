import 'package:cloud_firestore/cloud_firestore.dart';

class TimeSeriesSales {
  final DateTime time;
  final int temp;

  TimeSeriesSales(this.time, this.temp);

  factory TimeSeriesSales.fromFirebase(Map<String, dynamic> data) {
    Timestamp timestamp = data['times'];
    int value = data['valor'];

    return TimeSeriesSales(timestamp.toDate(), value);
  }
}

Future<List<TimeSeriesSales>> getDataFromFirebase() async {
  List<TimeSeriesSales> timeSeriesData = [];

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('temp').get();

  snapshot.docs.forEach((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    TimeSeriesSales timeSeries = TimeSeriesSales.fromFirebase(data);
    timeSeriesData.add(timeSeries);
  });

  return timeSeriesData;
}
