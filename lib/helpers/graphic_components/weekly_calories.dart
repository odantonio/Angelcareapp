import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

class WeeklyCalories extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final DateTime date;
  const WeeklyCalories({
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
        'name': Variable(
          accessor: (Map map) => '',
        ),
      },
      marks: [
        IntervalMark(
          size: SizeEncode(value: 25),
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
        //renderer: (anchor, selectedTuples) =>            customTooltip(anchor, selectedTuples, ['name']),
      ),
    );
  }
}
