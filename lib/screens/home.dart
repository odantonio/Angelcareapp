import '../helpers/screen_components/ui_ux/custom_bottom_navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/screen_components/ui_ux/user_stats_card.dart';
import '../helpers/screen_components/ui_ux/simple_appbar.dart';
import '../helpers/models/user-model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserModel? currentUser;

  SnapshotOptions? _;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _logout() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  void _handlelogout() async {
    _logout();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }

  Future<UserModel?> _getUserData() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final FirebaseFirestore db = FirebaseFirestore.instance;
      final userQuerySnapshot =
          await db.collection("users").where("id", isEqualTo: userId).get();

      if (userQuerySnapshot.docs.isNotEmpty) {
        final docId = userQuerySnapshot.docs.first.id;
        final docSnapshot = await db.collection("users").doc(docId).get();

        if (docSnapshot.exists) {
          return UserModel.fromFirestore(docSnapshot, _);
        }
      }

      return null; // or return a default value if you prefer
    } catch (e) {
      print('Erro ao obter os dados do usuário: $e');
      return null; // or return a default value if you prefer
    }
  }

  void _getCurrentUser() async {
    final user = await _getUserData();
    if (mounted) {
      // Verifica se o widget ainda está montado
      setState(() {
        currentUser = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AuthAppbar(
              logout: _handlelogout,
              theme: 'dark',
              showAvatar: true,
              onTap: () {
                // TODO: Implement onTap functionality
              },
            ),
            UserStatsCard(
              name: currentUser?.fullName ?? 'user',
              avatar: currentUser?.image,
              showSettings: true,
              theme: 'dark',
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  '',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        )),
        bottomNavigationBar: BottomNavigationCustom(
          currentIndex: 0,
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: 0,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.bluetooth),
        //       label: 'Conectar Dispositivo',
        //     ),
        //   ],
        // ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // TODO: Implement drawer item functionality
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // TODO: Implement drawer item functionality
                },
              ),
            ],
          ),
        ));
  }
}
