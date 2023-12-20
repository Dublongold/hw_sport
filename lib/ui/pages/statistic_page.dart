import 'package:flutter/material.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/constants/strings.dart';
import 'package:hw_sport/models/quiz_types.dart';
import 'package:hw_sport/models/statistic_entity.dart';
import 'package:hw_sport/ui/components/statistic_item.dart';
import 'package:hw_sport/ui/components/with_bottom_buttons.dart';
import 'package:provider/provider.dart';
import '../../constants/cricket_quiz.dart' as cricket;
import '../../constants/basketball_quiz.dart' as basketball;
import '../../constants/soccer_quiz.dart' as soccer;

import '../../states/quiz_state.dart';

class StatisticPage extends StatefulWidget {
  final QuizType quizType;
  const StatisticPage({super.key, required this.quizType});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {

  List<int> answers = [];

  List<int> get _correctAnswers => switch(widget.quizType) {
    QuizType.cricket => cricket.correctAnswers,
    QuizType.basketball => basketball.correctAnswers,
    QuizType.soccer => soccer.correctAnswers,
    QuizType.none => List.empty(),
  };

  @override
  void initState() {
    super.initState();
    answers = Provider.of<QuizState>(context, listen: false).answers;
  }

  onPopInvoked(result) {
    setState(() {
      QuizState state = Provider.of(context, listen: false);
      answers = state.answers;
    });
  }

  @override
  Widget build(BuildContext context) {
    var items = <StatisticEntity?>[
      for (int i = 0; i < answers.length; i++)
        StatisticEntity(
          quizType: widget.quizType,
          questionNumber: i,
          answer: answers[i],
          answerState: answers[i] == -1 ? AnswerState.timeExpired : (answers[i] == _correctAnswers[i] ? AnswerState.done : AnswerState.failed),
          onPopInvoked: onPopInvoked
        )
    ];
    if (items.length < 20) {
      items.addAll(List.generate(20 - items.length, (index) => null));
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: WithBottomButtons(
        disabledButton: 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                height: 80,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    statisticString.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.2
                    ),
                  ),
                ),
              ),
              for (int index = 0; index < items.length; index++)
                StatisticItem(
                  isOdd: index % 2 == 1,
                  statisticEntity: items[index],
                  ),
              const Padding(
                padding: EdgeInsets.only(bottom: 110),
              )
            ],
          ),
        ),
      ),
    );
  }
}
