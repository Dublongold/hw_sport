import 'package:flutter/material.dart';
import 'package:hw_sport/constants/arrays.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/constants/strings.dart';
import 'package:hw_sport/extentions/string.dart';
import 'package:hw_sport/ui/pages/quiz_page.dart';

import '../../models/progress_entity.dart';

class ProgressItem extends StatelessWidget {
  final bool isOdd;
  final int questionNumber;
  final String? answer;
  final AnswerState answerState;
  final void Function(bool) onPopInvoked;

  const ProgressItem({
    super.key,
    required this.isOdd,
    required this.questionNumber,
    required this.answer,
    required this.answerState,
    required this.onPopInvoked,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: answerState != AnswerState.done ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: answerState != AnswerState.done ? () {
          var navigator = Navigator.of(context);
          navigator.push(
              MaterialPageRoute(builder: (context) {
                return PopScope(
                  onPopInvoked: onPopInvoked,
                    child: QuizPage(questionNumber: questionNumber + 1, getTimeFromState: false, isRetry: true,)
                );
              })
          );
        } : null,
        child: Container(
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
                        questions[questionNumber],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          height: 1.07,
                          letterSpacing: 0.01,
                          fontFamily: "Arial",
                        ),
                        selectionColor: Colors.white),
                    Text(switch(answerState) {
                      AnswerState.done => correctAnswerString.format([answer]),
                      AnswerState.failed => incorrectAnswerString.format([answer]),
                      AnswerState.timeExpired => timeExpiredString,
                    }, style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold,
                      fontSize: 14
                    )
                    )
                  ],
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        "res/images/${answerState == AnswerState.done ? 'done' : 'try_again'}_mark.png",
                        height: 25,
                        width: 70,
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
