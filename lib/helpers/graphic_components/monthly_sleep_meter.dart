import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../date_time_format.dart';

class MonthlySleepMeter extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final DateTime date;
  const MonthlySleepMeter({
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
          accessor: (Map map) => map['date'] as num,
          scale: LinearScale(
            min: firstDayInMonth.millisecondsSinceEpoch,
            max: lastDayInMonth.millisecondsSinceEpoch,
            tickCount: 15,
            formatter: (num num) {
              return DateTime.fromMillisecondsSinceEpoch(num.toInt())
                  .day
                  .toString();
            },
          ),
        ),
        'lightStart': Variable(
          accessor: (Map map) => map['light']['start'] as num,
          scale: LinearScale(
            formatter: (num num) => getOnlyHoursFromMinutes(num.floor()),
            min: 0,
            max: 1440,
            tickCount: 12,
          ),
        ),
        'lightEnd': Variable(
          accessor: (Map map) => map['light']['end'] as num,
          scale: LinearScale(
            formatter: (num num) => getOnlyHoursFromMinutes(num.floor()),
            min: 0,
            max: 1440,
            tickCount: 12,
          ),
        ),
        'deepStart': Variable(
          accessor: (Map map) => map['deep']['start'] as num,
          scale: LinearScale(
            formatter: (num num) => getOnlyHoursFromMinutes(num.floor()),
            min: 0,
            max: 1440,
            tickCount: 12,
          ),
        ),
        'deepEnd': Variable(
          accessor: (Map map) => map['deep']['end'] as num,
          scale: LinearScale(
            formatter: (num num) => getOnlyHoursFromMinutes(num.floor()),
            min: 0,
            max: 1440,
            tickCount: 12,
          ),
        ),
        'bedTimeStart': Variable(
          accessor: (Map map) => map['bedTime']['start'] as num,
          scale: LinearScale(
            formatter: (num num) => getOnlyHoursFromMinutes(num.floor()),
            min: 0,
            max: 1440,
            tickCount: 12,
          ),
        ),
        'bedTimeEnd': Variable(
          accessor: (Map map) => map['bedTime']['end'] as num,
          scale: LinearScale(
            formatter: (num num) => getOnlyHoursFromMinutes(num.floor()),
            min: 0,
            max: 1440,
            tickCount: 12,
          ),
        ),
        'name': Variable(
          accessor: (Map map) => '',
        ),
      },
      marks: [
        IntervalMark(
          layer: 3,
          size: SizeEncode(value: 5),
          color: ColorEncode(
            value: const Color.fromRGBO(29, 113, 184, 1),
          ),
          position:
              Varset('date') * (Varset('lightStart') + Varset('lightEnd')),
          shape: ShapeEncode(value: RectShape()),
        ),
        IntervalMark(
          layer: 2,
          size: SizeEncode(value: 5),
          color: ColorEncode(
            value: const Color.fromRGBO(113, 164, 206, 1),
          ),
          position: Varset('date') * (Varset('deepStart') + Varset('deepEnd')),
          shape: ShapeEncode(value: RectShape()),
        ),
        IntervalMark(
          layer: 1,
          size: SizeEncode(value: 5),
          color: ColorEncode(
            value: const Color.fromRGBO(198, 215, 229, 1),
          ),
          position:
              Varset('date') * (Varset('bedTimeStart') + Varset('bedTimeEnd')),
          shape: ShapeEncode(value: RectShape()),
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
        //renderer: (anchor, selectedTuples) =>
        //    customTooltip(anchor, selectedTuples, [
        // 'name',
        //  'bedTimeStart',
        //  'deepStart',
        //  'lightStart'
        // ], {
        //  'bedTimeEnd': (int start, int end) {
        //    return 'Tempo de cama ${minutuesToHourAndMinutes(start - end)}';
        //  },
        // 'lightEnd': (int start, int end) {
        //    return 'Sono leve ${minutuesToHourAndMinutes(start - end)}';
        //  },
        //  'deepEnd': (int start, int end) {
        //    return 'Sono profundo ${minutuesToHourAndMinutes(start - end)}';
        //  }
        // ),
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
