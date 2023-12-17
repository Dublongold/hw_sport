import 'package:flutter/material.dart';
import 'package:hw_sport/constants/arrays.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/constants/shared_preferences.dart';
import 'package:hw_sport/constants/strings.dart';
import 'package:hw_sport/ui/components/statistic_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/statistic_entity.dart';
import '../../util/convert_saved_statistic_data.dart';


class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  static const defaultValue = (0, 0, 0.0);
  List<(int, int, double)> correctToIncorrect = [
    for(int i = 0; i < questions.length; i++)
      defaultValue,
  ];

  @override
  void initState() {
    super.initState();
    fetchStatistic();
  }

  Future<void> fetchStatistic() async {
      SharedPreferences shared = await SharedPreferences.getInstance();
      List<String>? savedStatisticData = shared.getStringList(sharedStatisticData);
      setState(() {
        correctToIncorrect = convertFromSavedStatisticData(savedStatisticData);
      });
  }

  @override
  Widget build(BuildContext context) {
    final items = <StatisticEntity>[
      for (int i = 0; i < questions.length; i++)
        StatisticEntity(text: questions[i],
            numberOfCorrectAnswers: correctToIncorrect[i].$1,
            numberOfIncorrectAnswers: correctToIncorrect[i].$2,
            averageTimeToAnswer: correctToIncorrect[i].$3
        )
    ];
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 40)),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 15.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                iconSize: 32,
                highlightColor: Colors.white12,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int index = 0; index < questions.length; index++)
                      StatisticItem(
                          isOdd: index % 2 == 1,
                          statisticEntity: items[index]
                      ),

                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: TextButton(
                        onPressed: () {
                          SharedPreferences.getInstance().then((value) {
                            value.setStringList(sharedStatisticData, convertToSavedStatisticData(defaultSavedStatisticData));
                          });
                          setState(() {
                            correctToIncorrect = defaultSavedStatisticData;
                          });
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(Colors.white12)
                        ),
                        child: const Text(
                          clearDataString,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Arial"
                          ),
                        )
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}
