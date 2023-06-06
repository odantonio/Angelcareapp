import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/user-model.dart';

class AccountDrawer extends StatelessWidget {
  final String? user;
  final void Function() logout;
  const AccountDrawer({
    Key? key,
    required this.user,
    required this.logout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 45,
                    width: 45,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        )),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          '${!kIsWeb ? 'assets/' : ''}images/default-avatar.png'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        "name",
                        style: Theme.of(context).textTheme.titleMedium!.merge(
                              const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              color: Color(0xffE5E5E5),
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(34),
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Perfil'),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text('Segurança'),
                  onTap: () {
                    Navigator.pushNamed(context, '/security');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.people_alt_outlined),
                  title: const Text('Controle de usuário'),
                  onTap: () {
                    Navigator.pushNamed(context, '/userControl');
                  },
                ),
                const ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text('Pagamento'),
                )
              ],
            ),
            const Divider(
              height: 2,
              thickness: 2,
              color: Color(0xffE5E5E5),
            ),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(34),
              children: [
                const ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('Ajuda'),
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Sair'),
                  onTap: () => logout(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
