import 'package:cloud_firestore/cloud_firestore.dart';

class CalibrationModel {
  String? min;
  String? max;
  String? target;

  CalibrationModel({this.min, this.max, this.target});

  factory CalibrationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CalibrationModel(
      min: data?['min'],
      max: data?['max'],
      target: data?['target'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (min != null) 'min': min,
      if (max != null) 'max': max,
      if (target != null) 'target': target,
    };
  }
}
