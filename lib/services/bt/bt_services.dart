import 'dart:async';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// Função para converter um valor hexadecimal em texto
String hexToString(String hex) {
  var buffer = StringBuffer();
  for (var i = 0; i < hex.length; i += 2) {
    buffer.writeCharCode(int.parse(hex.substring(i, i + 2), radix: 16));
  }
  return buffer.toString();
}

Future<void> subscribeAndReadTemp(BluetoothDevice device) async {
  // Discover services
  List<BluetoothService> services = await device.discoverServices();

  // Find the service with the specified UUID
  BluetoothService? service;
  for (BluetoothService s in services) {
    if (s.uuid.toString() == '6e40001-b5a3-f393-e0a9-e50e24dcca9e') {
      service = s;
      break;
    }
  }

  if (service != null) {
    // encontra a característica com uuid específico
    BluetoothCharacteristic? characteristic;
    for (BluetoothCharacteristic c in service.characteristics) {
      if (c.uuid.toString() == '6e40003-b5a3-f393-e0a9-e50e24dcca9e') {
        characteristic = c;
        break;
      }
    }

    if (characteristic != null) {
      if (characteristic.properties.read && characteristic.properties.notify) {
        // Inscreve na característica
        await characteristic.setNotifyValue(true);

        // Configura o stream notification
        StreamSubscription<List<int>> subscription;
        subscription = characteristic.value.listen((value) {
          // Recebe o valor hexa
          String hexValue = hex.encode(value);

          // Converte o valor hexa para string
          String textValue = hexToString(hexValue);

          if (kDebugMode) {
            print('Value received: $textValue');
          }
        });

        // Inicia a leitura da caracteristica
        List<int> value = await characteristic.read();

        // valor recebido em hexa
        String hexValue = hex.encode(value);

        // Converte o valor hexa para string
        String textValue = hexToString(hexValue);

        if (kDebugMode) {
          print('Value read: $textValue');
        }
      } else {
        if (kDebugMode) {
          print('The characteristic does not support read or notify');
        }
      }
    } else {
      if (kDebugMode) {
        print('Characteristic not found');
      }
    }
  } else {
    if (kDebugMode) {
      print('Service not found');
    }
  }
}

String extractTemperature(String phrase) {
  // Encontra a posição inicial do valor
  int startIndex = phrase.indexOf(':') + 1;

  // Encontra a posição final do valor
  int endIndex = phrase.indexOf('-', startIndex);

  // Extrai a substring contendo o valor
  String valueString = phrase.substring(startIndex, endIndex).trim();

  // Converte a string em um número de ponto flutuante
  double value = double.parse(valueString);

  // Formata o valor com uma casa decimal
  String formattedValue = value.toStringAsFixed(1);

  return formattedValue;
}

Future<void> subscribeAndReadHeart(BluetoothDevice device) async {
  // Discover services
  List<BluetoothService> services = await device.discoverServices();

  // Find the service with the specified UUID
  BluetoothService? service;
  for (BluetoothService s in services) {
    if (s.uuid.toString() == '180D') {
      service = s;
      break;
    }
  }

  if (service != null) {
    // encontra a característica com uuid específico
    BluetoothCharacteristic? characteristic;
    for (BluetoothCharacteristic c in service.characteristics) {
      if (c.uuid.toString() == '6e40003-b5a3-f393-e0a9-e50e24dcca9e') {
        characteristic = c;
        break;
      }
    }

    if (characteristic != null) {
      if (characteristic.properties.read && characteristic.properties.notify) {
        // Inscreve na característica
        await characteristic.setNotifyValue(true);

        // Configura o stream notification
        StreamSubscription<List<int>> subscription;
        subscription = characteristic.value.listen((value) {
          // Recebe o valor hexa
          String hexValue = hex.encode(value);

          // Converte o valor hexa para string
          String textValue = hexToString(hexValue);

          if (kDebugMode) {
            print('Value received: $textValue');
          }
        });

        // Inicia a leitura da caracteristica
        List<int> value = await characteristic.read();

        // valor recebido em hexa
        String hexValue = hex.encode(value);

        // Converte o valor hexa para string
        String textValue = hexToString(hexValue);

        if (kDebugMode) {
          print('Value read: $textValue');
        }
      } else {
        if (kDebugMode) {
          print('The characteristic does not support read or notify');
        }
      }
    } else {
      if (kDebugMode) {
        print('Characteristic not found');
      }
    }
  } else {
    if (kDebugMode) {
      print('Service not found');
    }
  }
}
