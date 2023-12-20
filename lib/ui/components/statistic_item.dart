import 'package:flutter/material.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/models/quiz_types.dart';
import 'package:hw_sport/constants/strings.dart';
import 'package:hw_sport/extentions/string.dart';
import 'package:hw_sport/ui/components/button_with_two_images.dart';
import 'package:hw_sport/ui/pages/quiz_page.dart';
import '../../constants/basketball_quiz.dart' as basketball;
import '../../constants/cricket_quiz.dart' as cricket;
import '../../constants/soccer_quiz.dart' as soccer;

import '../../models/statistic_entity.dart';

class StatisticItem extends StatelessWidget {
  final bool isOdd;
  final StatisticEntity? statisticEntity;

  List<String> get _questions => switch(statisticEntity?.quizType) {
    QuizType.cricket => cricket.questions,
    QuizType.basketball => basketball.questions,
    QuizType.soccer => soccer.questions,
    QuizType.none || null => List.empty(),
  };
  List<List<String>> get _answers => switch(statisticEntity?.quizType) {
    QuizType.cricket => cricket.answers,
    QuizType.basketball => basketball.answers,
    QuizType.soccer => soccer.answers,
    QuizType.none || null => List.empty(),
  };

  const StatisticItem({
    super.key,
    required this.isOdd,
    required this.statisticEntity
  });

  @override
  Widget build(BuildContext context) {
    var localStatisticEntity = statisticEntity;
    if (localStatisticEntity != null) {
      String answer = localStatisticEntity.answer != -1 ? _answers[localStatisticEntity.questionNumber][localStatisticEntity.answer] : timeExpiredString;
      String buttonSuffix = localStatisticEntity.answerState == AnswerState.done ? 'done' : 'try_again';
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
                      _questions[localStatisticEntity.questionNumber],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        height: 1.07,
                        letterSpacing: 0.01,
                        fontFamily: "Arial",
                      ),
                      selectionColor: Colors.white),
                  Padding(
                    padding: const EdgeInsets.only(right: 75.0),
                    child: Text(switch(localStatisticEntity.answerState) {
                      AnswerState.done => correctAnswerString.format([answer]),
                      AnswerState.failed => incorrectAnswerString.format([answer]),
                      AnswerState.timeExpired => timeExpiredString,
                    }, style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: -0.2
                    )
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      height: 25,
                      width: 70,
                      child: ButtonWithTwoImages(
                          isEnabled: true,
                          imageAssetPressed: "res/images/button_$buttonSuffix(pressed).png",
                          imageAssetUnpressed: "res/images/button_$buttonSuffix.png",
                          disabledImageAsset: "res/images/button_$buttonSuffix.png",
                          action: () {
                            var navigator = Navigator.of(context);
                            navigator.push(
                                MaterialPageRoute(builder: (context) {
                                  return PopScope(
                                      onPopInvoked: localStatisticEntity.onPopInvoked,
                                      child: QuizPage(
                                        questionNumber: localStatisticEntity.questionNumber,
                                        quizType: localStatisticEntity.quizType,
                                        isRetry: true,
                                      )
                                  );
                                })
                            );
                          }
                      ),
                    )
                ),
              ),
            )
          ],
        ),
      );
    }
    else {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: isOdd ? oddItemColor : evenItemColor),
        height: 80,
      );
    }
  }
}
