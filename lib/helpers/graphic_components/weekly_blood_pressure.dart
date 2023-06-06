import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class WeeklyBloodPresure extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final DateTime date;
  const WeeklyBloodPresure({
    Key? key,
    required this.data,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = date;
    final lastDayOfTheWeek =
        today.add(Duration(days: DateTime.daysPerWeek - today.weekday));
    final firstDayOfWeek = today.subtract(Duration(days: today.weekday));
    return Chart(
      padding: (_) => const EdgeInsets.all(0),
      data: data,
      variables: {
        'date': Variable(
          accessor: (Map map) => map['date'] as num,
          scale: LinearScale(
            min: firstDayOfWeek.millisecondsSinceEpoch,
            max: lastDayOfTheWeek.millisecondsSinceEpoch,
            tickCount: 7,
            formatter: (num num) {
              switch (
                  DateTime.fromMillisecondsSinceEpoch(num.toInt()).weekday) {
                case 1:
                  return 'Seg';
                case 2:
                  return 'Ter';
                case 3:
                  return 'Qua';
                case 4:
                  return 'Qui';
                case 5:
                  return 'Sex';
                case 6:
                  return 'Sab';
                case 7:
                  return 'Dom';
                default:
                  return '';
              }
            },
          ),
        ),
        'dia': Variable(
          accessor: (Map map) => map['dia'] as num,
          scale: LinearScale(
            formatter: (num num) => num.floor().toString(),
            min: 50,
            max: 150,
            tickCount: 5,
          ),
        ),
        'sis': Variable(
          accessor: (Map map) => map['sis'] as num,
          scale: LinearScale(
            formatter: (num num) => num.floor().toString(),
            min: 50,
            max: 150,
            tickCount: 5,
          ),
        ),
        'name': Variable(
          accessor: (Map map) => '',
        ),
      },
      marks: [
        LineMark(
          position: Varset('date') * Varset('sis') / Varset('name'),
          shape: ShapeEncode(
            value: BasicLineShape(
              smooth: false,
            ),
          ),
          size: SizeEncode(value: 3),
          color: ColorEncode(
            variable: 'name',
            values: [
              const Color.fromRGBO(126, 87, 194, 1),
              const Color.fromRGBO(126, 87, 194, 1)
            ],
            updaters: {
              'groupMouse': {false: (color) => color.withAlpha(100)},
              'groupTouch': {false: (color) => color.withAlpha(100)},
            },
          ),
        ),
        PointMark(
          position: Varset('date') * Varset('sis') / Varset('name'),
          size: SizeEncode(
            variable: 'name',
            values: [8, 8],
          ),
          shape: ShapeEncode(
            variable: 'name',
            values: [
              CircleShape(hollow: false, strokeWidth: 3),
              CircleShape(hollow: false, strokeWidth: 3),
            ],
          ),
          color: ColorEncode(
            variable: 'name',
            values: [
              const Color.fromRGBO(126, 87, 194, 1),
              const Color.fromRGBO(126, 87, 194, 1),
            ],
            updaters: {
              'groupMouse': {false: (color) => color.withAlpha(100)},
              'groupTouch': {false: (color) => color.withAlpha(100)},
            },
          ),
        ),
        PointMark(
          position: Varset('date') * Varset('sis') / Varset('name'),
          size: SizeEncode(
            variable: 'name',
            values: [3, 3],
          ),
          shape: ShapeEncode(
            variable: 'name',
            values: [
              CircleShape(hollow: false, strokeWidth: 3),
              CircleShape(hollow: false, strokeWidth: 3),
            ],
          ),
          color: ColorEncode(
            variable: 'name',
            values: [
              Colors.white,
              Colors.white,
            ],
            updaters: {
              'groupMouse': {false: (color) => color.withAlpha(100)},
              'groupTouch': {false: (color) => color.withAlpha(100)},
            },
          ),
        ),
        LineMark(
          position: Varset('date') * Varset('dia') / Varset('name'),
          shape: ShapeEncode(
            value: BasicLineShape(
              smooth: false,
            ),
          ),
          size: SizeEncode(value: 3),
          color: ColorEncode(
            variable: 'name',
            values: [
              const Color.fromRGBO(179, 157, 219, 1),
              const Color.fromRGBO(179, 157, 219, 1)
            ],
            updaters: {
              'groupMouse': {false: (color) => color.withAlpha(100)},
              'groupTouch': {false: (color) => color.withAlpha(100)},
            },
          ),
        ),
        PointMark(
          position: Varset('date') * Varset('dia') / Varset('name'),
          size: SizeEncode(
            variable: 'name',
            values: [8, 8],
          ),
          shape: ShapeEncode(
            variable: 'name',
            values: [
              CircleShape(hollow: false, strokeWidth: 3),
              CircleShape(hollow: false, strokeWidth: 3),
            ],
          ),
          color: ColorEncode(
            variable: 'name',
            values: [
              const Color.fromRGBO(179, 157, 219, 1),
              const Color.fromRGBO(179, 157, 219, 1)
            ],
            updaters: {
              'groupMouse': {false: (color) => color.withAlpha(100)},
              'groupTouch': {false: (color) => color.withAlpha(100)},
            },
          ),
        ),
        PointMark(
          position: Varset('date') * Varset('dia') / Varset('name'),
          size: SizeEncode(
            variable: 'name',
            values: [3, 3],
          ),
          shape: ShapeEncode(
            variable: 'name',
            values: [
              CircleShape(hollow: false, strokeWidth: 3),
              CircleShape(hollow: false, strokeWidth: 3),
            ],
          ),
          color: ColorEncode(
            variable: 'name',
            values: [
              Colors.white,
              Colors.white,
            ],
            updaters: {
              'groupMouse': {false: (color) => color.withAlpha(100)},
              'groupTouch': {false: (color) => color.withAlpha(100)},
            },
          ),
        ),
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
      selections: {
        'tooltipMouse': PointSelection(
          on: {
            GestureType.hover,
          },
          devices: {PointerDeviceKind.mouse},
        ),
        'groupMouse': PointSelection(
          on: {
            GestureType.hover,
          },
          variable: 'name',
          devices: {
            PointerDeviceKind.mouse,
          },
        ),
        'tooltipTouch': PointSelection(on: {
          GestureType.scaleUpdate,
          GestureType.tapDown,
          GestureType.longPressMoveUpdate
        }, devices: {
          PointerDeviceKind.touch
        }),
        'groupTouch': PointSelection(
            on: {
              GestureType.scaleUpdate,
              GestureType.tapDown,
              GestureType.longPressMoveUpdate
            },
            variable: 'name',
            devices: {PointerDeviceKind.touch}),
      },
      tooltip: TooltipGuide(
        layer: 4,
        selections: {'tooltipTouch', 'tooltipMouse'},
        followPointer: [true, true],
        align: Alignment.topLeft,
        //renderer: (anchor, selectedTuples) =>       customTooltip(anchor, selectedTuples, ['name']),
      ),
      crosshair: CrosshairGuide(
        selections: {'tooltipTouch', 'tooltipMouse'},
        styles: [
          PaintStyle(strokeColor: const Color(0xffbfbfbf)),
          PaintStyle(strokeColor: const Color(0x00bfbfbf)),
        ],
        followPointer: [true, false],
      ),
    );
  }
}
