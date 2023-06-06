import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//import '../../helpers/date_time_format.dart';
import '../../services/database/firestore.dart';
import '../models/monitored.dart';
import '../screen_components/theme/angel-care_theme.dart';

class HomeListTile extends StatefulWidget {
  final bool isLastItem;
  final MonitoredModel monitored;
  const HomeListTile({
    Key? key,
    required this.isLastItem,
    required this.monitored,
  }) : super(key: key);

  @override
  State<HomeListTile> createState() => _HomeListTileState();
}

class _HomeListTileState extends State<HomeListTile> {
  late MonitoredModel monitored;
  late MonitoredModel monitor;
  late final bool isLastItem;

  void getMonitor() async {
    final data = await FirebaseActivity.retrieveMonitored();
    monitor = data!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(
                    '${!kIsWeb ? 'assets/' : ''}images/default-avatar.png')),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Olavo Borges D'Antonio",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            subtitle: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Icon(
                          Icons.timer_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 24,
                        ),
                      ),
                      Text(
                        '10 min',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ),
                //if (monitored.monitors != null)
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Text(
                        'Monitor: ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Column(children: [
                        Text(
                          monitor.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ]),
                    ],
                  ),
                )
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/monitoredStats',
                  arguments: monitored,
                );
              },
            ),
          ),
          !isLastItem
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(
                    height: 1,
                    color: Theme.of(context).colorScheme.grey4,
                    thickness: 1,
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
