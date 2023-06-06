import 'package:flutter/material.dart';

class ChartSubtitle extends StatelessWidget {
  final String maxValue;
  final String unit;
  final Color color;
  final double fontSize;
  final String? valueSufix;
  const ChartSubtitle({
    Key? key,
    required this.maxValue,
    required this.color,
    required this.unit,
    this.fontSize = 12,
    this.valueSufix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 8, height: 8, color: color),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    unit,
                    style:
                        Theme.of(context).textTheme.labelSmall!.merge(TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize,
                            )),
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  maxValue.toString(),
                  style: valueSufix != null
                      ? Theme.of(context).textTheme.bodyLarge
                      : Theme.of(context).textTheme.titleLarge,
                ),
              ),
              if (valueSufix != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 0, 4),
                  child: Text(
                    valueSufix!,
                    style:
                        Theme.of(context).textTheme.labelSmall!.merge(TextStyle(
                              fontSize: fontSize,
                            )),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
