import 'package:AngelCare/screens/blood.dart';
import 'package:AngelCare/screens/device_screen.dart';
import 'package:AngelCare/screens/heart.dart';
import 'package:AngelCare/screens/oxygenation.dart';
import 'package:AngelCare/screens/temp.dart';
import 'package:provider/provider.dart';

import '/services/database/auth_gate.dart';
import 'package:flutter/material.dart';

import 'helpers/form/form_emergency_contacts.dart';
import 'helpers/form/form_first_page.dart';
import 'helpers/form/form_second_page.dart';
import 'helpers/form/form_third_page.dart';
import 'helpers/screen_components/theme/angel-care_theme.dart';
import 'helpers/form/form_data.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'helpers/models/blood_data.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    * Cuidado com o provedor de estados,
    * dependendo de qual usar o Firebase também vai entender como
    * etado dele e vai exigir que OAUTH do Facebook e Twitter sejam passados.
    *
    * Isso vai complicado quando for feito a versão para IOS, pois nele já é passado
    * a necessidade destes modulos, se vc ler o arquivo de configuração do projeto.
    * Problema que eu ia resolver somente em momento oportuno.
    * */
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,

        /// classe theme é declarada no angel-care_theme. Ele está usando o Material2. Não fui eu quem construiu.
        title: 'Angel Care',
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthGate(),

          /// esta classe está em serviços, não em screens.
          '/first': (context) => const FirstFormPage(),
          '/second': (context) => const SecondFormPage(),
          '/third': (context) => const ThirdFormPage(),
          '/home': (context) => const Home(),
          '/device': (context) => const DeviceScreen(),
          '/emergency': (context) => const EmergencyContactsForm(),
          '/profile': (context) => const UserDocumentPage(),
          '/blood': (context) => BloodPage(),
          '/temp': (context) => TemperaturePage(),
          '/o2': (context) => O2Page(),
          '/heart': (context) => HeartPage(),
        },
      ),
    );
  }
}
