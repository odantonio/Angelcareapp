import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class MonthlyBloodPresure extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final DateTime date;
  const MonthlyBloodPresure({
    Key? key,
    required this.data,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final month = date.month;
    final year = date.year;
    final lastDayInMonth = DateTime(year, month + 1, 1);
    final firstDayInMonth = DateTime(year, month, 0);

    return Chart(
      padding: (_) => const EdgeInsets.all(0),
      data: data,
      variables: {
        'date': Variable(
          accessor: (Map map) => map['date'] as int,
          scale: LinearScale(
            min: firstDayInMonth.millisecondsSinceEpoch,
            max: lastDayInMonth.millisecondsSinceEpoch,
            tickCount: 15,
            formatter: (num num) =>
                DateTime.fromMillisecondsSinceEpoch(num.toInt()).day.toString(),
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
        // renderer: (anchor, selectedTuples) => customTooltip(anchor, selectedTuples, ['name']),
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
