import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import '../../models/nearby_device.dart';
//import '../../models/monitored_model.dart';
//import '../../providers/cubits/device_cubit.dart';

class BottomNavigationCustom extends StatefulWidget {
  final int currentIndex;
  final bool showSelected;
  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Emergency Contacts', 'route': '/emergency'},
    {'title': 'Profile', 'route': '/profile'},
  ];
  //final DeviceState? currentDeviceState;
  final void Function()? openBttomSheet;
  //final List<NearbyDevice>? bluetoothDevices;
  //final List<Monitor>? monitors;
  BottomNavigationCustom({
    Key? key,
    required this.currentIndex,
    this.showSelected = true,
    //this.currentDeviceState,
    this.openBttomSheet,
    //this.bluetoothDevices,
    //this.monitors,
  }) : super(key: key);

  @override
  State<BottomNavigationCustom> createState() => _BottomNavigationCustomState();
}

class _BottomNavigationCustomState extends State<BottomNavigationCustom>
    with TickerProviderStateMixin {
  bool isBluetoothConnected = false;

  void _logout() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, //Para column navigation bar
      children: [
        //if (widget.currentDeviceState is ShowDevicesBottomBar)
        Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          color: Theme.of(context).colorScheme.secondary,
          child: GestureDetector(
            onTap: widget.openBttomSheet,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 15,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Container(
                                width: 25,
                                height: 25,
                                color: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 15,
                            top: 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.error,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                width: 20,
                                height: 20,
                                child: const Center(
                                  child: Text(
                                    'E66+ BD86',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Ver dispositivos',
                        style: Theme.of(context).textTheme.bodyMedium!.merge(
                              const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.expand_less,
                  size: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
        //if (widget.monitors != null)
        // Container(
        //   padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
        //   color: Theme.of(context).colorScheme.secondary,
        //   child: GestureDetector(
        //     onTap: widget.openBttomSheet,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: [
        //         Row(
        //           crossAxisAlignment: CrossAxisAlignment.end,
        //           children: [
        //             SizedBox(
        //               width: 40,
        //               height: 40,
        //               child: Stack(
        //                 children: [
        //                   Positioned(
        //                     left: 0,
        //                     top: 15,
        //                     child: ClipRRect(
        //                       borderRadius: BorderRadius.circular(12.0),
        //                       child: Container(
        //                         width: 25,
        //                         height: 25,
        //                         color: Colors.white,
        //                         child: Icon(
        //                           Icons.person,
        //                           color:
        //                               Theme.of(context).colorScheme.secondary,
        //                           size: 16,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Positioned(
        //                     left: 15,
        //                     top: 5,
        //                     child: ClipRRect(
        //                       borderRadius: BorderRadius.circular(12.0),
        //                       child: Container(
        //                         decoration: BoxDecoration(
        //                           color: Theme.of(context).colorScheme.error,
        //                           borderRadius: BorderRadius.circular(12.0),
        //                           border: Border.all(
        //                             color: Colors.white,
        //                             width: 2,
        //                           ),
        //                         ),
        //                         width: 20,
        //                         height: 20,
        //                         child: const Center(
        //                           child: Text(
        //                             'Lista de dados do monitorado',
        //                             style: TextStyle(
        //                                 color: Colors.white, fontSize: 12),
        //                           ),
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             //if (widget.monitors != null)
        //             Padding(
        //               padding: const EdgeInsets.only(bottom: 5),
        //               child: Text(
        //                 //widget.monitors!.isEmpty
        //                 'Nenhum monitor associado',
        //                 style: Theme.of(context).textTheme.bodyMedium!.merge(
        //                       const TextStyle(
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //               ),
        //             ),
        //           ],
        //         ),
        //         const Icon(
        //           Icons.expand_less,
        //           size: 30,
        //           color: Colors.white,
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        BottomNavigationBar(
          selectedItemColor: widget.showSelected
              ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
              : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          type: BottomNavigationBarType.fixed,
          onTap: (idx) {
            if (idx != widget.currentIndex) {
              if (idx == 0) {
                Navigator.pushNamed(
                  context,
                  '/',
                );
              }
              if (idx == 1) {
                Navigator.pushNamed(context, '/device');
              }
              if (idx == 2) {
                // Navigator.pushNamed(context, '/subscriptions');
              }
              if (idx == 3) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Menu'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.people),
                            title: Text('Profile'),
                            onTap: () {
                              Navigator.pop(context); // Fechar o AlertDialog
                              Navigator.pushNamed(context,
                                  '/profile'); // Navegar para a rota '/profile'
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.warning),
                            title: Text('Emergency Contacts'),
                            onTap: () {
                              Navigator.pop(context); // Fechar o AlertDialog
                              Navigator.pushNamed(context,
                                  '/emergency'); // Navegar para a rota '/emergency'
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.logout),
                            title: const Text('logout'),
                            onTap: () {
                              _logout(); // Navegar para a rota '/emergency'
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }
          },
          currentIndex: widget.currentIndex,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.house),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: isBluetoothConnected
                  ? Icon(Icons.bluetooth_connected)
                  : Icon(Icons.bluetooth),
              label: 'Dispositivos',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: 'Assinaturas',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Perfil',
            ),
          ],
        ),
      ],
    );
  }
}
