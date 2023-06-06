import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserStatsCard extends StatelessWidget {
  final String name;
  final String? avatar;
  final bool showSettings;
  final String theme;
  const UserStatsCard({
    Key? key,
    required this.name,
    required this.avatar,
    this.showSettings = true,
    this.theme = 'dark',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 16),
      decoration: theme == 'dark'
          ? BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary
              ]),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListTile(
          leading: Container(
            height: 60,
            width: 56,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                )),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: avatar != null
                  ? NetworkImage(avatar!)
                  : const AssetImage(
                          '${!kIsWeb ? 'assets/' : ''}images/default-avatar.png')
                      as ImageProvider,
            ),
          ),
          title: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(
              'Visualizando dados de',
              style: Theme.of(context).textTheme.bodyMedium!.merge(
                    TextStyle(
                      color: theme == 'dark'
                          ? Colors.white
                          : Theme.of(context).textTheme.displayLarge!.color,
                    ),
                  ),
            ),
          ),
          subtitle: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(
              name,
              style: Theme.of(context).textTheme.headlineSmall!.merge(
                    TextStyle(
                        color: theme == 'dark'
                            ? Colors.white
                            : Theme.of(context).textTheme.displayLarge!.color,
                        fontWeight: FontWeight.bold),
                  ),
            ),
          ),
          trailing: showSettings
              ? IconButton(
                  icon: Icon(
                    Icons.monitor,
                    color: theme == 'dark'
                        ? Colors.white
                        : Theme.of(context).textTheme.displayLarge!.color,
                    size: 26,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Monitores Corporais'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListTile(
                                  title: const Text('Temperatura'),
                                  onTap: () {
                                    Navigator.pop(context); // Close the dialog
                                    Navigator.pushNamed(context, '/temp');
                                  },
                                ),
                                ListTile(
                                  title: const Text('Pressão Sanguínea'),
                                  onTap: () {
                                    Navigator.pop(context); // Close the dialog
                                    Navigator.pushNamed(context, '/blood');
                                  },
                                ),
                                ListTile(
                                  title: const Text('Oxigenação'),
                                  onTap: () {
                                    Navigator.pop(context); // Close the dialog
                                    Navigator.pushNamed(context, '/o2');
                                  },
                                ),
                                ListTile(
                                  title: const Text('Batimentos Cardíacos'),
                                  onTap: () {
                                    Navigator.pop(context); // Close the dialog
                                    Navigator.pushNamed(context, '/heart');
                                  },
                                ),
                                // Add more list items for additional screens
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
              : null,
        ),
      ),
    );
  }
}
