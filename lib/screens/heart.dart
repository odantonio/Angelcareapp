import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';

import '../helpers/models/heart_data.dart';

final _monthDayFormat = DateFormat('HH:mm');

class HeartPage extends StatefulWidget {
  HeartPage({Key? key}) : super(key: key);

  @override
  State<HeartPage> createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
  final Future<List<TimeSeriesSales>> _dataFuture = getDataFromFirebase();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Batimentos Cardíacos'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 5),
                child: const Text(
                  'Histórico de Batimentos Cardíacos',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 430,
                height: 200,
                child: FutureBuilder<List<TimeSeriesSales>>(
                  future: _dataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Erro ao carregar os dados');
                    } else if (snapshot.hasData) {
                      return Chart(
                        data: snapshot.data!,
                        variables: {
                          'Hora': Variable(
                            accessor: (TimeSeriesSales datum) => datum.time,
                            scale: TimeScale(
                              formatter: (time) => _monthDayFormat.format(time),
                            ),
                          ),
                          'BPM': Variable(
                            accessor: (TimeSeriesSales datum) => datum.max,
                          ),
                        },
                        marks: [
                          LineMark(
                            shape: ShapeEncode(
                                value: BasicLineShape(dash: [5, 2])),
                            selected: {
                              'touchMove': {1}
                            },
                          ),
                        ],
                        coord: RectCoord(color: const Color(0xffdddddd)),
                        axes: [
                          Defaults.horizontalAxis,
                          Defaults.verticalAxis,
                        ],
                        selections: {
                          'touchMove': PointSelection(
                            on: {
                              GestureType.scaleUpdate,
                              GestureType.tapDown,
                              GestureType.longPressMoveUpdate
                            },
                            dim: Dim.x,
                          )
                        },
                        tooltip: TooltipGuide(
                          followPointer: [false, true],
                          align: Alignment.topLeft,
                          offset: const Offset(-20, 20),
                        ),
                        crosshair: CrosshairGuide(followPointer: [false, true]),
                      );
                    } else {
                      return Text('Nenhum dado disponível');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:graphic/graphic.dart';
// import '../helpers/models/blood_data.dart';
//
// class DailyHeartChartDialog extends StatelessWidget {
//   final List<Map<String, dynamic>> data;
//
//   const DailyHeartChartDialog({Key? key, required this.data}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         width: 400,
//         height: 400,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Expanded(
//               child: DailyHeart(data: data),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DailyHeart extends StatelessWidget {
//   final List<Map<String, dynamic>> data;
//
//   const DailyHeart({Key? key, required this.data}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Chart(
//       padding: (_) => const EdgeInsets.all(0),
//       data: data,
//       variables: {
//         'hour': Variable(
//           accessor: (Map map) {
//             final int millisecondsSinceEpoch = map['hour'];
//             final DateTime dateTime =
//                 DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
//             return '${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
//           },
//           scale: LinearScale(
//             formatter: (num num) => num.floor().toString(),
//             min: -1,
//             max: 25,
//             tickCount: 13,
//           ),
//         ),
//         'bpm': Variable(
//           accessor: (Map map) => map['bpm'] as num,
//           scale: LinearScale(
//             formatter: (num num) => num.floor().toString(),
//             min: 30,
//             max: 50,
//             tickCount: 5,
//           ),
//         ),
//         'name': Variable(
//           accessor: (Map map) => '',
//         ),
//       },
//       marks: [
//         LineMark(
//           position: Varset('hour') * Varset('bpm') / Varset('name'),
//           shape: ShapeEncode(
//             value: BasicLineShape(
//               smooth: false,
//             ),
//           ),
//           size: SizeEncode(value: 3),
//           color: ColorEncode(
//             variable: 'name',
//             values: [
//               const Color.fromRGBO(63, 81, 181, 1),
//               const Color.fromRGBO(63, 81, 181, 1)
//             ],
//             updaters: {
//               'groupMouse': {false: (color) => color.withAlpha(100)},
//               'groupTouch': {false: (color) => color.withAlpha(100)},
//             },
//           ),
//         ),
//         PointMark(
//           size: SizeEncode(
//             variable: 'name',
//             values: [8, 8],
//           ),
//           shape: ShapeEncode(
//             variable: 'name',
//             values: [
//               CircleShape(hollow: false, strokeWidth: 3),
//               CircleShape(hollow: false, strokeWidth: 3),
//             ],
//           ),
//           color: ColorEncode(
//             variable: 'name',
//             values: [
//               const Color.fromRGBO(63, 81, 181, 1),
//               const Color.fromRGBO(63, 81, 181, 1),
//             ],
//             updaters: {
//               'groupMouse': {false: (color) => color.withAlpha(100)},
//               'groupTouch': {false: (color) => color.withAlpha(100)},
//             },
//           ),
//         ),
//         PointMark(
//           size: SizeEncode(
//             variable: 'name',
//             values: [3, 3],
//           ),
//           shape: ShapeEncode(
//             variable: 'name',
//             values: [
//               CircleShape(hollow: false, strokeWidth: 3),
//               CircleShape(hollow: false, strokeWidth: 3),
//             ],
//           ),
//           color: ColorEncode(
//             variable: 'name',
//             values: [
//               Colors.white,
//               Colors.white,
//             ],
//             updaters: {
//               'groupMouse': {false: (color) => color.withAlpha(100)},
//               'groupTouch': {false: (color) => color.withAlpha(100)},
//             },
//           ),
//         ),
//       ],
//       axes: [
//         Defaults.horizontalAxis,
//         Defaults.verticalAxis,
//       ],
//       selections: {
//         'tooltipMouse': PointSelection(
//           on: {
//             GestureType.hover,
//           },
//           devices: {PointerDeviceKind.mouse},
//         ),
//         'groupMouse': PointSelection(
//           on: {
//             GestureType.hover,
//           },
//           variable: 'name',
//           devices: {
//             PointerDeviceKind.mouse,
//           },
//         ),
//         'tooltipTouch': PointSelection(on: {
//           GestureType.scaleUpdate,
//           GestureType.tapDown,
//           GestureType.longPressMoveUpdate
//         }, devices: {
//           PointerDeviceKind.touch
//         }),
//         'groupTouch': PointSelection(
//             on: {
//               GestureType.scaleUpdate,
//               GestureType.tapDown,
//               GestureType.longPressMoveUpdate
//             },
//             variable: 'name',
//             devices: {PointerDeviceKind.touch}),
//       },
//       tooltip: TooltipGuide(
//         layer: 4,
//         selections: {'tooltipTouch', 'tooltipMouse'},
//         followPointer: [true, true],
//         align: Alignment.topLeft,
//         // renderer: (anchor, selectedTuples) => customTooltip(anchor, selectedTuples, ['name']),
//       ),
//       crosshair: CrosshairGuide(
//         selections: {'tooltipTouch', 'tooltipMouse'},
//         styles: [
//           PaintStyle(strokeColor: const Color(0xffbfbfbf)),
//           PaintStyle(strokeColor: const Color(0x00bfbfbf)),
//         ],
//         followPointer: [true, false],
//       ),
//     );
//   }
// }
//
// class HeartPage extends StatefulWidget {
//   const HeartPage({super.key});
//
//   @override
//   State<HeartPage> createState() => _HeartPageState();
// }
//
// class _HeartPageState extends State<HeartPage> {
//   bool isLoading = false;
//   bool isHistoricView = false;
//
//   Future<void> fetchData() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     // Simulating loading delay
//     await Future.delayed(const Duration(seconds: 18));
//
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   void showHeartChartDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return DailyHeartChartDialog(data: heartData);
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Batimento Cardíaco'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text('Selecione a Leitura:'),
//             const SizedBox(height: 16),
//             ToggleButtons(
//               isSelected: [!isHistoricView, isHistoricView],
//               onPressed: (index) {
//                 setState(() {
//                   isHistoricView = index == 1;
//                 });
//               },
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Text('Leitura Atual'),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Text('Leitura do Histórico'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: isLoading ? null : fetchData,
//               child: isLoading
//                   ? const CircularProgressIndicator()
//                   : const Text('Lendo...'),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: isLoading ? null : showHeartChartDialog,
//               child: const Text(' '),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
