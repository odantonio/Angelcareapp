import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  List<ScanResult> scanResults = [];
  List<BluetoothDevice> connectedDevices = [];
  StreamSubscription? scanResultsSubscription;
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    _startScan();
    _getConnectedDevices();
  }

  @override
  void dispose() {
    scanResultsSubscription?.cancel();
    super.dispose();
  }

  void _startScan() {
    if (!mounted || isScanning) return;

    setState(() {
      scanResults.clear();
      isScanning = true;
    });

    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    scanResultsSubscription = flutterBlue.scanResults.listen((results) {
      if (!mounted) return;

      setState(() {
        scanResults = results;
      });
    });
  }

  Future<void> _getConnectedDevices() async {
    if (!mounted) return;

    final devices = await flutterBlue.connectedDevices;
    if (!mounted) return;

    setState(() {
      connectedDevices = devices;
    });
  }

  Future<void> _refresh() async {
    if (!mounted || isScanning) return;

    await flutterBlue.stopScan();
    _startScan();
  }

  void _connectToDevice(BluetoothDevice device) async {
    if (!mounted) return;

    await device.connect();
    if (!mounted) return;

    setState(() {
      connectedDevices.add(device);
    });
  }

  void _disconnectDevice(BluetoothDevice device) async {
    if (!mounted) return;

    await device.disconnect();
    if (!mounted) return;

    setState(() {
      connectedDevices.remove(device);
    });
  }

  Widget _buildDeviceList(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Dispositivos Disponíveis:',
          style: Theme.of(context).textTheme.headline6,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: scanResults.length,
          itemBuilder: (context, index) {
            final result = scanResults[index];
            final device = result.device;
            final isDeviceConnected = connectedDevices.contains(device);

            return ListTile(
              title: Text(device.name),
              subtitle: Text(device.id.toString()),
              trailing: ElevatedButton(
                onPressed: () {
                  if (isDeviceConnected) {
                    _disconnectDevice(device);
                  } else {
                    _connectToDevice(device);
                  }
                },
                child: Text(isDeviceConnected ? 'Desconectar' : 'Conectar'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildConnectedDeviceList(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Dispositivos Conectados:',
          style: Theme.of(context).textTheme.headline6,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: connectedDevices.length,
          itemBuilder: (context, index) {
            final device = connectedDevices[index];

            return ListTile(
              title: Text(device.name),
              subtitle: Text(device.id.toString()),
              trailing: ElevatedButton(
                onPressed: () {
                  _disconnectDevice(device);
                },
                child: const Text('Desconectar'),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositivos Bluetooth'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDeviceList(context),
          _buildConnectedDeviceList(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
