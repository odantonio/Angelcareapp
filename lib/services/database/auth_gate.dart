import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart ';
import 'package:flutterfire_ui/auth.dart';

import '../../screens/verification.dart';

/*
* AuthGate é o portal de autorização padrão do Firebase.
* o Firebase tem seu próprio controle de estado.
* SignInScreen é uma página própria do pacote firebase.
* Aqui estou o flutterfire, mas ele é um pacote antigo,
* o pacote novo é firebase. algumas poucas alterações. Eu não vi necessidade em alterar pra ele,
* pode ser que vc que está lendo tenha, pois a documentação informa que flutterfire não é compatível com
* flutter 3.
*
* Apesar das Telas de autenticação, registro e recuperação de senha do usuário
* serem do flutterfire ou firebase, vc poderá trabalhar algumas características delas.
*
* Optei por usar o emailProvider como método único de autenticação.
* Implicações: no firebase este método deve estar habilitado.
* O firebase vai criar e usar uma base de dados a parte. Vc precisa garantir que os dados sejam tratados.
*
* Ao registar um usuário, é atribuido um userID pela autenticação; então email, password, imagem de avatar,
* serão tratados e armazenados no banco de autenticação do usuário.
* Os dados podem ser recuperados pela classe FirebaseAuth.
* */
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs: const [
              EmailProviderConfiguration(),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 0.5,
                  child: SvgPicture.asset('assets/images/Logo.svg'),
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text(
                        'Bem vindo ao Angel Care, por favor faça login!')
                    : const Text(
                        'Bem vindo ao Angel Care, por favor crie uma conta!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Ao Entrar você concorda com nossos termos e condições',

                  ///style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 0.5,
                  child: SvgPicture.asset('assets/images/Logo.svg'),
                ),
              );
            },
          );
        }
        return const VerificationPage();
      },
    );
  }
}
