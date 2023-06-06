import '../helpers/models/monitored.dart';
import 'package:flutter/material.dart';

import '../date_time_format.dart';
import '../models/monitored.dart';
import '../models/monitored_statistics_model.dart';
import '../screen_components/ui_ux/angel_care_icons_icons.dart';
import '../screen_components/ui_ux/stats_card.dart';

class MonitoredStatisticsWidget extends StatelessWidget {
  final MonitoredModel monitored;
  final MonitoredStatistics monitoredStats;
  final String userId;
  const MonitoredStatisticsWidget({
    Key? key,
    required this.monitoredStats,
    required this.monitored,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatsCard(
          color: const Color.fromRGBO(240, 98, 146, 1),
          icon: Icons.favorite_border,
          name: "Frequência cardíaca",
          date: monitoredStats.date,
          value: numberFormat
              .format(monitoredStats.heartFrequency.value)
              .toString(),
          status: monitoredStats.heartFrequency.status,
          unit: 'bmp',
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/heartFrequency',
              arguments: {
                "monitored": monitored,
                "stat": monitoredStats.heartFrequency,
                "date": monitoredStats.date,
                "allStats": monitoredStats
              },
            );
          },
        ),
        StatsCard(
          color: const Color.fromRGBO(38, 198, 218, 1),
          icon: Icons.air,
          name: "Oxigenação",
          date: monitoredStats.date,
          value:
              numberFormat.format(monitoredStats.oxygenation.value).toString(),
          status: monitoredStats.oxygenation.status,
          unit: 'Sp02',
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/oxygenation',
              arguments: {
                "monitored": monitored,
                "stat": monitoredStats.oxygenation,
                "date": monitoredStats.date,
                "allStats": monitoredStats
              },
            );
          },
        ),
        StatsCard(
          color: const Color.fromRGBO(92, 107, 192, 1),
          icon: Icons.thermostat,
          name: "Temperatura",
          date: monitoredStats.date,
          value:
              numberFormat.format(monitoredStats.temperature.value).toString(),
          status: monitoredStats.temperature.status,
          unit: '°C',
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/temperature',
              arguments: {
                "monitored": monitored,
                "stat": monitoredStats.temperature,
                "date": monitoredStats.date,
                "allStats": monitoredStats
              },
            );
          },
        ),
        // StatsCard(
        //   color: const Color.fromRGBO(41, 182, 246, 1),
        //   icon: AngelCareIcons.lung,
        //   name: "Frequência respiratório",
        //   date: monitoredStats.date,
        //   value: numberFormat
        //       .format(monitoredStats.respiratoryFrequency.value)
        //       .toString(),
        //   status: monitoredStats.respiratoryFrequency.status,
        //   unit: 'rpm',
        //   onPressed: () {
        //     Navigator.pushNamed(
        //       context,
        //       '/respiratoryFrequency',
        //       arguments: {
        //         "monitored": monitored,
        //         "stat": monitoredStats.respiratoryFrequency,
        //         "date": monitoredStats.date,
        //         "allStats": monitoredStats
        //       },
        //     );
        //   },
        // ),
        StatsCard(
          color: const Color.fromRGBO(126, 87, 194, 1),
          icon: Icons.invert_colors,
          name: "Pressão sanguínea",
          date: monitoredStats.date,
          value: monitoredStats.bloodPressure.value,
          status: monitoredStats.bloodPressure.status,
          unit: 'mmHG',
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/bloodPresure',
              arguments: {
                "monitored": monitored,
                "stat": monitoredStats.bloodPressure,
                "date": monitoredStats.date,
                "allStats": monitoredStats
              },
            );
          },
        ),
        // StatsCard(
        //   color: const Color.fromRGBO(124, 179, 66, 1),
        //   icon: Icons.directions_walk,
        //   name: "Medidor de passos",
        //   date: monitoredStats.date,
        //   value: numberFormat.format(monitoredStats.stepMeter.value).toString(),
        //   status: monitoredStats.stepMeter.status,
        //   unit: 'passos',
        //   onPressed: () {
        //     Navigator.pushNamed(
        //       context,
        //       '/stepmeter',
        //       arguments: {
        //         "monitored": monitored,
        //         "stat": monitoredStats.stepMeter,
        //         "date": monitoredStats.date,
        //         "allStats": monitoredStats
        //       },
        //     );
        //   },
        // ),
        // StatsCard(
        //   color: const Color.fromRGBO(38, 166, 154, 1),
        //   icon: AngelCareIcons.fire,
        //   name: "Calorias",
        //   date: monitoredStats.date,
        //   value: numberFormat.format(monitoredStats.calories.value).toString(),
        //   status: monitoredStats.calories.status,
        //   unit: 'kcal',
        //   onPressed: () {
        //     Navigator.pushNamed(
        //       context,
        //       '/calories',
        //       arguments: {
        //         "monitored": monitored,
        //         "stat": monitoredStats.calories,
        //         "date": monitoredStats.date,
        //         "allStats": monitoredStats
        //       },
        //     );
        //   },
        // ),
        // StatsCard(
        //   color: const Color.fromRGBO(29, 113, 184, 1),
        //   icon: Icons.hotel_outlined,
        //   name: "Medidor de sono",
        //   date: monitoredStats.date,
        //   value: secondsToHourAndMinutes(monitoredStats.sleepMeter.value),
        //   status: monitoredStats.sleepMeter.status,
        //   unit: 'horas',
        //   onPressed: () {
        //     Navigator.pushNamed(
        //       context,
        //       '/sleepmeter',
        //       arguments: {
        //         "monitored": monitored,
        //         "stat": monitoredStats.sleepMeter,
        //         "date": monitoredStats.date,
        //         "allStats": monitoredStats
        //       },
        //     );
        //   },
        // ),
        GestureDetector(
          onTap: () => {
            // TODO: passar user.id para comparar com monitored.id
            //monitored.id == userId?
            Navigator.pushNamed(
              context,
              '/myDailyRecords',
              arguments: {'isMonitor': true, 'monitored': monitored},
            ): Navigator.pushNamed(
              context,
              '/myDailyRecords',
              arguments: {'isMonitor': false, 'monitored': monitored},
            )
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary
                  ]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(26, 24, 26, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: Icon(
                                Icons.tag_faces,
                                color: Colors.white,
                                size: 34,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              // TODO: passar user.id para comparar com monitored.id
                              child: Text(
                                //monitored.id == userId?
                                'Meu diário',
                                //    : 'Diário do monitorado',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .merge(
                                      const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              ),
                            ),
                            // TODO: passar user.id para comparar com monitored.id
                            Text(
                              //monitored.id == userId?
                              'Acompanhe seu dia-a-dia e como está se sentido ao longo das semanas.',
                              // : 'Acompanhe o dia-a-dia de como o monitorado está se sentido ao longo das semanas.',
                              style:
                                  Theme.of(context).textTheme.bodySmall!.merge(
                                        const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                            )
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
