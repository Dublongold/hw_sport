import 'package:flutter/material.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/constants/strings.dart';
import 'package:hw_sport/extentions/string.dart';
import 'package:hw_sport/models/statistic_entity.dart';

class StatisticItem extends StatelessWidget {
  const StatisticItem(
      {super.key,
      required this.isOdd,
      required this.statisticEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: isOdd ? oddItemColor : evenItemColor),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    questionString.format([statisticEntity.text]),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      height: 1.07,
                      letterSpacing: 0.01,
                      fontFamily: "Arial",
                    ),
                    selectionColor: Colors.white),
                infoText(averageTimeToAnswerString, [
                  statisticEntity.averageTimeToAnswer
                ]),
                infoText(
                  answersGivenString, [
                    statisticEntity.numberOfCorrectAnswers,
                    statisticEntity.numberOfIncorrectAnswers
                  ]
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text infoText(String text, List<dynamic> format) {
    return Text(
      text.format(format),
      style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15
      ),
    );
  }

  final bool isOdd;
  final StatisticEntity statisticEntity;
}
