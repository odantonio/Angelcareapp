import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class DailyCalories extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const DailyCalories({
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
        'kcal': Variable(
          accessor: (Map map) => map['kcal'] as num,
          scale: LinearScale(
            formatter: (num num) => num.floor().toString(),
            min: 0,
            max: 1000,
            tickCount: 5,
          ),
        ),
        'kcalDay': Variable(
          accessor: (Map map) => map['kcalDay'] as num,
          scale: LinearScale(
            formatter: (num num) => num.floor().toString(),
            min: 0,
            max: 1000,
            tickCount: 5,
          ),
        ),
        'name': Variable(
          accessor: (Map map) => '',
        ),
      },
      marks: [
        IntervalMark(
          layer: 2,
          size: SizeEncode(value: 7),
          color: ColorEncode(
            value: const Color.fromRGBO(38, 166, 154, 1),
          ),
          position: Varset('hour') * Varset('kcal'),
          shape: ShapeEncode(
              value: RectShape(
            borderRadius: BorderRadius.circular(0),
          )),
        ),
        LineMark(
          layer: 1,
          position: Varset('hour') * Varset('kcalDay'),
          shape: ShapeEncode(
            value: BasicLineShape(
              smooth: false,
            ),
          ),
          size: SizeEncode(value: 3),
          color: ColorEncode(
            variable: 'name',
            values: [
              const Color.fromRGBO(178, 223, 219, 1),
              const Color.fromRGBO(178, 223, 219, 1)
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
        //renderer: (anchor, selectedTuples) => customTooltip(anchor, selectedTuples, ['name']),
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
