import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class MontlyCalories extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final DateTime date;
  const MontlyCalories({
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
        'min': Variable(
          accessor: (Map map) => map['min'] as num,
          scale: LinearScale(
            formatter: (num num) => num.floor().toString(),
            min: 0,
            max: 4000,
            tickCount: 5,
          ),
        ),
        'max': Variable(
          accessor: (Map map) => map['max'] as num,
          scale: LinearScale(
            formatter: (num num) => num.floor().toString(),
            min: 0,
            max: 4000,
            tickCount: 5,
          ),
        ),
      },
      marks: [
        IntervalMark(
          size: SizeEncode(value: 7),
          color: ColorEncode(
            value: const Color.fromRGBO(38, 166, 154, 1),
          ),
          position: Varset('date') * (Varset('min') + Varset('max')),
          shape: ShapeEncode(
              value: RectShape(
            borderRadius: BorderRadius.circular(2),
          )),
        )
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
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
    );
  }
}
