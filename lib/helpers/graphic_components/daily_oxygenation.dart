import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class DailyOxigenation extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const DailyOxigenation({
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
        'sp02': Variable(
          accessor: (Map map) => map['sp02'] as num,
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
          position: Varset('hour') * Varset('sp02') / Varset('name'),
          shape: ShapeEncode(
            value: BasicLineShape(
              smooth: false,
            ),
          ),
          size: SizeEncode(value: 3),
          color: ColorEncode(
            variable: 'name',
            values: [
              const Color.fromRGBO(38, 198, 218, 1),
              const Color.fromRGBO(38, 198, 218, 1)
            ],
            updaters: {
              'groupMouse': {false: (color) => color.withAlpha(100)},
              'groupTouch': {false: (color) => color.withAlpha(100)},
            },
          ),
        ),
        PointMark(
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
              const Color.fromRGBO(38, 198, 218, 1),
              const Color.fromRGBO(38, 198, 218, 1),
            ],
            updaters: {
              'groupMouse': {false: (color) => color.withAlpha(100)},
              'groupTouch': {false: (color) => color.withAlpha(100)},
            },
          ),
        ),
        PointMark(
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
