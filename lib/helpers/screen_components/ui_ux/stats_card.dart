import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/angel-care_theme.dart';

class StatsCard extends StatelessWidget {
  final Color color;
  final DateTime date;
  final String value;
  final String status;
  final IconData icon;
  final String unit;
  final String name;
  final void Function()? onPressed;
  final Function()? onPressedCalibration;
  final dynamic min;
  final dynamic max;
  final dynamic target;
  final bool isBloodPressure;
  const StatsCard({
    Key? key,
    required this.color,
    required this.date,
    required this.status,
    required this.value,
    required this.icon,
    required this.name,
    required this.unit,
    this.onPressed,
    this.min,
    this.max,
    this.target,
    this.isBloodPressure = false,
    this.onPressedCalibration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: status == 'high'
                  ? Theme.of(context).colorScheme.error
                  : status == 'low'
                      ? Theme.of(context).colorScheme.warning
                      : Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26, 24, 26, 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Icon(
                      icon,
                      color: status == 'high'
                          ? Theme.of(context).colorScheme.error
                          : status == 'low'
                              ? Theme.of(context).colorScheme.warning
                              : color,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              DateFormat('dd/MM/YYYY hh:mm').format(date),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .merge(
                                    TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.grey5,
                                    ),
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Icon(
                                color: Theme.of(context).colorScheme.grey5,
                                Icons.replay,
                                size: 12,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  onPressed != null
                      ? IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            color: Theme.of(context).colorScheme.grey5,
                          ),
                          onPressed: onPressed,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        value.toString(),
                        style: TextStyle(
                          color: status == 'high'
                              ? Theme.of(context).colorScheme.error
                              : status == 'low'
                                  ? Theme.of(context).colorScheme.warning
                                  : color,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          unit,
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.grey5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  status == 'high' || status == 'low'
                      ? Container(
                          decoration: BoxDecoration(
                            color: status == 'high'
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).colorScheme.warning,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Text(
                              status == 'high' ? 'Alto' : 'Baixo',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
              if (min != null && max != null)
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(
                        height: 2,
                        thickness: 2,
                        color: Color(0xffE5E5E5),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.speed,
                            color: status == 'high'
                                ? Theme.of(context).colorScheme.error
                                : status == 'low'
                                    ? Theme.of(context).colorScheme.warning
                                    : color,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  'Calibrar alcance',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: isBloodPressure
                                      ? 'Sistólica: '
                                      : 'Mínima: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .merge(
                                        TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .grey5,
                                        ),
                                      ),
                                  children: [
                                    TextSpan(
                                      text: min.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: isBloodPressure
                                          ? ' | Diastólica:'
                                          : ' | Máxima:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .merge(
                                            TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .grey5,
                                            ),
                                          ),
                                    ),
                                    TextSpan(
                                      text: max.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            color: Theme.of(context).colorScheme.grey5,
                          ),
                          onPressed: onPressedCalibration ??
                              () =>
                                  Navigator.pushNamed(context, '/calibration'),
                        ),
                      ],
                    )
                  ],
                ),
              if (target != null)
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Divider(
                        height: 2,
                        thickness: 2,
                        color: Color(0xffE5E5E5),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.speed,
                            color: status == 'high'
                                ? Theme.of(context).colorScheme.error
                                : status == 'low'
                                    ? Theme.of(context).colorScheme.warning
                                    : color,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  'Calibrar alcance',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Alvo: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .merge(
                                        TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .grey5,
                                        ),
                                      ),
                                  children: [
                                    TextSpan(
                                      text: target.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            color: Theme.of(context).colorScheme.grey5,
                          ),
                          onPressed: onPressed ??
                              () =>
                                  Navigator.pushNamed(context, '/calibration'),
                        ),
                      ],
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
