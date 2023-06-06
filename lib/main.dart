// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutterfire_ui/auth.dart';
// import 'app.dart';
// import 'firebase_options.dart';
//
// import 'package:permission_handler/permission_handler.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   if (Firebase.apps.isEmpty) {
//     await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform);
//   } else {
//     Firebase.app();
//   }
//
//   FlutterFireUIAuth.configureProviders([
//     const EmailProviderConfiguration(),
//   ]);
//   runApp(const MyApp());
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfire_ui/auth.dart';
import 'dart:io';
import 'app.dart';
import 'firebase_options.dart';

import 'package:permission_handler/permission_handler.dart';

/*
* O projeto AngelCare foi escrito e compilado usado:
* Flutter 3.10.2
* Dart 3.0.2
* Java SDK 1.8
* Material 2.
* Flutter_Blue_Plus precisa ser a versão 1.4.0 mínima. Estou usando o 1.5.0.
*
* Nos AndroidManifests, há a duplicação das permissões. Mantenha.
* Eu enfrentei problemas para que o pacote funcionasse e só resolvi o
* problema seguindo essa recomendação do fórum StackOverflow.
* Ainda assim, verá mensagem no logcaat informando a falta de permissões.
*
* =============================================================================
* * Por necessidade, a inicialiação dos módulos Firebase e Bluetooth se dão
* em duas etapas.
*
* Não coloque e não deixe o DART ou Flutter analyzer acresentar
* dart:html por que o Firebase vai erroneamente a necessidade
* de configurar módulos web como o Facebook e Twitter
* OAUTH.
* */
Future<void> initializeFirebaseAndRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    Firebase.app();
  }

  FlutterFireUIAuth.configureProviders([
    const EmailProviderConfiguration(),
  ]);
  runApp(const MyApp());
}
/*
* Inicialização do módulo bluetooth e chamada
* para inicializar o módulo do Firebase.
* */

void main() async {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request().then((status) async {
      await initializeFirebaseAndRunApp();
    });
  } else {
    await initializeFirebaseAndRunApp();
  }
}
