import 'package:cloud_firestore/cloud_firestore.dart';

class TimeSeriesSales {
  final DateTime time;
  final int value;

  TimeSeriesSales(this.time, this.value);

  factory TimeSeriesSales.fromFirebase(Map<String, dynamic> data) {
    Timestamp timestamp = data['time'];
    int value = data['valor'];

    return TimeSeriesSales(timestamp.toDate(), value);
  }
}

Future<List<TimeSeriesSales>> getDataFromFirebase() async {
  List<TimeSeriesSales> timeSeriesData = [];

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('oxigenio').get();

  snapshot.docs.forEach((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    TimeSeriesSales timeSeries = TimeSeriesSales.fromFirebase(data);
    timeSeriesData.add(timeSeries);
  });

  return timeSeriesData;
}
