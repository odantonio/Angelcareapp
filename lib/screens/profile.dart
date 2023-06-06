import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helpers/models/user-model.dart';

class UserDocumentPage extends StatefulWidget {
  const UserDocumentPage({Key? key}) : super(key: key);
  @override
  State<UserDocumentPage> createState() => _UserDocumentPageState();
}

class _UserDocumentPageState extends State<UserDocumentPage> {
  UserModel? currentUser;

  SnapshotOptions? _;
  // Controladores para os campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _mainAddressController = TextEditingController();
  final TextEditingController _complAddressController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _documentTypeController = TextEditingController();
  final TextEditingController _documentNumberController =
      TextEditingController();
  //
  @override
  void dispose() {
    // Descarte os controladores ao sair da página para evitar vazamentos de memória
    _nameController.dispose();
    _ageController.dispose();
    _birthDateController.dispose();
    _mainAddressController.dispose();
    _complAddressController.dispose();
    _cepController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _phoneNumberController.dispose();
    _documentTypeController.dispose();
    _documentNumberController.dispose();
    //
    super.dispose();
  }

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
    if (user != null) {
      setState(() {
        currentUser = user;

        _nameController.text = currentUser?.fullName ?? 'N/A';
        _ageController.text = currentUser?.age.toString() ?? 'N/A';
        _birthDateController.text =
            currentUser?.birthDate?.toDate().toString() ?? 'N/A';
        _mainAddressController.text = currentUser?.mainAddress ?? 'N/A';
        _documentNumberController.text = currentUser?.documentNumber ?? 'N/A';
        _documentTypeController.text = currentUser?.documentType ?? 'N/A';
        _complAddressController.text = currentUser?.complAddress ?? 'N/A';
        _phoneNumberController.text = currentUser?.phoneNumber ?? 'N/A';
        _cepController.text = currentUser?.cep ?? 'N/A';
        _cityController.text = currentUser?.city ?? 'N/A';
        _stateController.text = currentUser?.state ?? 'N/A';
        _countryController.text = currentUser?.country ?? 'N/A';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados do Usuário'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Nome',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'Idade',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _ageController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'Data Nascimento',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _birthDateController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'Telefone',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'Documento',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _documentTypeController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'Nº do Documento',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _documentNumberController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'Endereço',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _mainAddressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'Complemento',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _complAddressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'Cidade',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _cityController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'Estado',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _stateController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'País',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _countryController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'CEP',
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    width: 16), // Espaço entre o rótulo e o TextFormField
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller: _cepController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: MaterialStateColor.resolveWith(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.focused)) {
                            return Colors.green;
                          }
                          if (states.contains(MaterialState.error)) {
                            return Colors.red;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Outros campos de texto
          ],
        ),
      ),
    );
  }
}
