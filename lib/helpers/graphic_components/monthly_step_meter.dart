import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class MontlyStepMeter extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final DateTime date;
  const MontlyStepMeter({
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
        'steps': Variable(
          accessor: (Map map) => map['steps'] as num,
          scale: LinearScale(
            // formatter: (num num) => num.floor().toString(),
            min: 0,
            max: 100000,
            tickCount: 5,
            formatter: (num num) {
              final number = num.floor();
              final dividedValue = (number / 100).floor();
              String finalValue = dividedValue > 1000
                  ? '>1'
                  : dividedValue == 1000
                      ? '1'
                      : '$dividedValue';
              finalValue += dividedValue >= 1000 ? ' mi' : ' mil';
              return finalValue;
            },
          ),
        ),
      },
      marks: [
        IntervalMark(
          size: SizeEncode(value: 7),
          color: ColorEncode(
            value: const Color.fromRGBO(139, 195, 74, 1),
          ),
          position: Varset('date') * Varset('steps'),
          shape: ShapeEncode(
              value: RectShape(
            borderRadius: BorderRadius.circular(2),
          )),
        )
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
        //renderer: (anchor, selectedTuples) =>customTooltip(anchor, selectedTuples, ['name']),
      ),
    );
  }
}
