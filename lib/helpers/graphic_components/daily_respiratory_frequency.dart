import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class DailyRespiratoryFrequency extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const DailyRespiratoryFrequency({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chart(
      padding: (_) => const EdgeInsets.all(0),
      data: data,
      variables: {
        'hour': Variable(
          accessor: (Map map) => map['hour'] as num,
          scale: LinearScale(
            formatter: (num num) => num.floor().toString(),
            min: -1,
            max: 25,
            tickCount: 13,
          ),
        ),
        'rpm': Variable(
          accessor: (Map map) => map['rpm'] as num,
          scale: LinearScale(
            formatter: (num num) => num.floor().toString(),
            min: 10,
            max: 70,
            tickCount: 5,
          ),
        ),
        'dailyGoal': Variable(
          accessor: (Map map) => map['dailyGoal'] as num,
          scale: LinearScale(
            formatter: (num num) => num.floor().toString(),
            min: 10,
            max: 70,
            tickCount: 5,
          ),
        ),
        'name': Variable(
          accessor: (Map map) => '',
        ),
      },
      marks: [
        LineMark(
          layer: 1,
          position: Varset('hour') * Varset('rpm'),
          shape: ShapeEncode(
            value: BasicLineShape(
              smooth: false,
            ),
          ),
          size: SizeEncode(value: 3),
          color: ColorEncode(
            variable: 'name',
            values: [
              const Color.fromRGBO(3, 169, 244, 1),
              const Color.fromRGBO(3, 169, 244, 1)
            ],
            updaters: {
              'groupMouse': {false: (color) => color.withAlpha(100)},
              'groupTouch': {false: (color) => color.withAlpha(100)},
            },
          ),
        ),
        PointMark(
          position: Varset('hour') * Varset('rpm'),
          layer: 1,
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
              const Color.fromRGBO(3, 169, 244, 1),
              const Color.fromRGBO(3, 169, 244, 1),
            ],
            updaters: {
              'groupMouse': {false: (color) => color.withAlpha(100)},
              'groupTouch': {false: (color) => color.withAlpha(100)},
            },
          ),
        ),
        LineMark(
          layer: 2,
          position: Varset('hour') * Varset('dailyGoal'),
          shape: ShapeEncode(
            value: BasicLineShape(
              smooth: false,
            ),
          ),
          size: SizeEncode(value: 3),
          color: ColorEncode(
            variable: 'name',
            values: [
              const Color.fromRGBO(179, 229, 252, 1),
              const Color.fromRGBO(179, 229, 252, 1)
            ],
            updaters: {
              'groupMouse': {false: (color) => color.withAlpha(100)},
              'groupTouch': {false: (color) => color.withAlpha(100)},
            },
          ),
        ),
        PointMark(
          position: Varset('hour') * Varset('dailyGoal'),
          layer: 2,
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
              const Color.fromRGBO(179, 229, 252, 1),
              const Color.fromRGBO(179, 229, 252, 1),
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
        // renderer: (anchor, selectedTuples) => customTooltip(anchor, selectedTuples, ['name', 'dailyGoal']),
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
