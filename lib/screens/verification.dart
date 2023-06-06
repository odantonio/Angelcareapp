import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screens/home.dart';
import '../../helpers/form/form_first_page.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _fetchUserDocument(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingScreen();
          } else if (snapshot.hasError) {
            return _buildErrorScreen();
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return const Home();
          } else {
            return const FirstFormPage();
          }
        },
      ),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> _fetchUserDocument(
      String? userId) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final QuerySnapshot<Map<String, dynamic>> userQuerySnapshot =
        await db.collection("users").where("id", isEqualTo: userId).get();

    return userQuerySnapshot;
  }

  Widget _buildLoadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorScreen() {
    return const Center(
      child: Text('An error occurred.'),
    );
  }
}
