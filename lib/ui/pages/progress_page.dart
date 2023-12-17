import 'package:flutter/material.dart';
import 'package:hw_sport/constants/arrays.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/models/page_entity.dart';
import 'package:hw_sport/models/progress_entity.dart';
import 'package:hw_sport/ui/components/progress_item.dart';
import 'package:hw_sport/ui/components/with_bottom_buttons.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../states/question_state.dart';

class ProgressPage extends StatefulWidget {
  final bool haveBackButton;
  final List<int> currentAnswers;
  const ProgressPage({super.key, this.haveBackButton = true, required this.currentAnswers});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {

  List<int> currentAnswers = [];

  @override
  void initState() {
    super.initState();
    currentAnswers = widget.currentAnswers;
  }

  @override
  Widget build(BuildContext context) {
    final items = <ProgressEntity>[
      for (int i = 0; i < currentAnswers.length; i++)
        ProgressEntity(
            questionNumber: i,
            answer: currentAnswers[i] != -1 ? answers[i][currentAnswers[i]] : null,
            answerState: currentAnswers[i] == -1 ? AnswerState.timeExpired : (currentAnswers[i] == correctAnswers[i] ? AnswerState.done : AnswerState.failed)
        )
    ];
    return Scaffold(
      backgroundColor: backgroundColor,
      body: WithBottomButtons(
        pageEntity: PageEntityProgress(currentAnswers.length),
        inactiveButton: 1,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 40)),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 15.0),
              child: widget.haveBackButton ? IconButton(
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
              ) : const SizedBox(width: 32, height: 32,),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int index = 0; index < currentAnswers.length; index++)
                      ProgressItem(
                        isOdd: index % 2 == 1,
                        questionNumber: items[index].questionNumber,
                        answer: items[index].answer,
                        answerState: items[index].answerState,
                        onPopInvoked: (result) {
                          setState(() {
                            QuestionState state = Provider.of(context, listen: false);
                            currentAnswers = state.answers;
                          });
                        },
                        ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 110),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
