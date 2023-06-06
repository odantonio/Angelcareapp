import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../helpers/models/monitored.dart';
import '../../helpers/models/user-model.dart';

class FirebaseActivity {
  static Future<String?> retrieveUserId() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    return userId;
  }

  static Future<UserModel?> retrieveUser() async {
    final userId = await retrieveUserId();
    if (userId != null) {
      final ref = FirebaseFirestore.instance.collection("users").doc('');
      final docSnap = await ref.get();
      final userData = docSnap.data();
      if (userData != null) {
        if (kDebugMode) {
          print("retrieveUserOK!");
        }
        return UserModel.fromFirestore(docSnap, null);
      } else {
        if (kDebugMode) {
          print("retrieveUserFalhou");
        }
      }
    }
    return null;
  }

  static Future<MonitoredModel?> retrieveMonitored() async {
    final userId = await retrieveUserId();
    if (userId != null) {
      final ref = FirebaseFirestore.instance.collection("monitored").doc();
      final docSnap = await ref.get();
      final monitoredData = docSnap.data();
      if (monitoredData != null) {
        if (kDebugMode) {
          print("OK!");
        }
        return MonitoredModel.fromFirestore(docSnap, null);
      } else {
        if (kDebugMode) {
          print("falha!");
        }
      }
    }
    return null;
  }
}
