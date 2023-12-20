import 'package:flutter/material.dart';
import 'package:hw_sport/constants/arrays.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/models/quiz_types.dart';
import 'package:hw_sport/ui/components/answer_option.dart';
import 'package:hw_sport/ui/components/button_with_two_images.dart';
import 'package:hw_sport/ui/components/with_bottom_buttons.dart';
import 'package:hw_sport/ui/pages/statistic_page.dart';
import 'package:provider/provider.dart';

import '../../constants/cricket_quiz.dart' as cricket;
import '../../constants/basketball_quiz.dart' as basketball;
import '../../constants/soccer_quiz.dart' as soccer;

import '../../states/quiz_state.dart';

class QuizPage extends StatefulWidget {
  /// Question number. <b>Must start <u>from</u> 0!</b>
  final int questionNumber;
  final QuizType quizType;
  final bool isRetry;

  const QuizPage(
      {super.key,
      this.questionNumber = 0,
      required this.quizType,
      this.isRetry = false});

  @override
  State<StatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  double time = 300;
  int questionNumber = 1;
  int selectedAnswer = -1;
  bool sent = false;

  List<int> get _correctAnswers => switch (widget.quizType) {
        QuizType.cricket => cricket.correctAnswers,
        QuizType.basketball => basketball.correctAnswers,
        QuizType.soccer => soccer.correctAnswers,
        QuizType.none => List.empty(),
      };

  List<String> get _questions => switch (widget.quizType) {
        QuizType.cricket => cricket.questions,
        QuizType.basketball => basketball.questions,
        QuizType.soccer => soccer.questions,
        QuizType.none => List.empty(),
      };

  List<List<String>> get _answers => switch (widget.quizType) {
        QuizType.cricket => cricket.answers,
        QuizType.basketball => basketball.answers,
        QuizType.soccer => soccer.answers,
        QuizType.none => List.empty(),
      };

  @override
  void initState() {
    super.initState();
    questionNumber = widget.questionNumber;
    startTimer();
  }

  Future<void> nextQuestion({void Function()? actionAfterSave}) async {
    if (!widget.isRetry) {
      if (mounted) {
        QuizState currentQuestionState =
            Provider.of<QuizState>(context, listen: false);
        currentQuestionState.nextQuestion(selectedAnswer);
      }
      actionAfterSave?.call();
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          if (questionNumber < 19) {
            return QuizPage(
                questionNumber: questionNumber + 1, quizType: widget.quizType);
          } else {
            return StatisticPage(quizType: widget.quizType);
          }
        }));
      }
    } else {
      if (mounted) {
        QuizState currentQuestionState =
            Provider.of<QuizState>(context, listen: false);
        currentQuestionState.changeAnswer(questionNumber, selectedAnswer);
      }
      actionAfterSave?.call();
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> startTimer() async {
    while (time > 0) {
      await Future.delayed(const Duration(milliseconds: 10));
      if (mounted) {
        if ((ModalRoute.of(context)?.isCurrent ?? false) == true) {
          setState(() {
            time -= 0.01;
          });
        } else {
          while (mounted && (ModalRoute.of(context)?.isCurrent ?? false)) {
            await Future.delayed(const Duration(milliseconds: 10));
          }
        }
      } else {
        break;
      }
    }
    if (time <= 0) {
      time = 0;
      setState(() {
        sent = true;
      });
      selectedAnswer = -1;
      nextQuestion(actionAfterSave: () {
        selectedAnswer = _correctAnswers[questionNumber];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: WithBottomButtons(
          disabledButton: widget.isRetry ? 1 : -1,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 7.0),
                            child: Image.asset(
                              "res/images/icon_timer.png",
                              width: 22,
                              height: 22,
                            ),
                          ),
                          LinearProgressIndicator(
                            backgroundColor: quizProgressBarBackgroundColor,
                            color: quizProgressBarColor,
                            value: time / 60,
                            minHeight: 13,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            time = 0.1;
                          });
                        },
                        child: Image.asset(
                          "res/images/cup.png",
                          width: 38,
                          height: 62,
                        )),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 7.0),
                              child: Text("${questionNumber + 1}/20")),
                          LinearProgressIndicator(
                            backgroundColor: quizProgressBarBackgroundColor,
                            color: quizProgressBarColor,
                            value: (questionNumber + 1) / 20,
                            minHeight: 13,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 50, bottom: 30),
                          child: Text(
                            _questions[questionNumber],
                            style: const TextStyle(
                              fontFamily: "Arial",
                              height: 1,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        for (int i = 0; i < 4; i++)
                          AnswerOption(
                            color: dependOnPicked(i),
                            imageAsset: optionImages[i],
                            text: _answers[questionNumber][i].substring(3),
                            selected: selectedAnswer == i && sent == false,
                            onSelected: !sent
                                ? () {
                                    setState(() {
                                      selectedAnswer = i;
                                    });
                                  }
                                : null,
                          ),
                        Padding(
                          padding: const EdgeInsets.only(
                                    bottom: 130, top: 50),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth: 260,
                              ),
                            child: AspectRatio(
                                aspectRatio: 436 / 127,
                                child: ButtonWithTwoImages(
                                        isEnabled: selectedAnswer != -1,
                                        imageAssetPressed:
                                            "res/images/button_submit(pressed).png",
                                        imageAssetUnpressed:
                                            "res/images/button_submit.png",
                                        disabledImageAsset:
                                            "res/images/button_submit.png",
                                        action: () {
                                          setState(() {
                                            sent = true;
                                          });
                                          nextQuestion();
                                        }),
                              ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Color dependOnPicked(int answerNumber) {
    if (selectedAnswer == -1 || selectedAnswer != answerNumber) {
      return unselectedAnswerColor;
    } else if (sent) {
      if (selectedAnswer == _correctAnswers[questionNumber]) {
        return correctAnswerColor;
      } else {
        return incorrectAnswerColor;
      }
    } else {
      return selectedAnswerColor;
    }
  }
}
