import 'package:flutter/material.dart';
import 'package:hw_sport/constants/arrays.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/constants/shared_preferences.dart';
import 'package:hw_sport/models/page_entity.dart';
import 'package:hw_sport/ui/components/answer_option.dart';
import 'package:hw_sport/ui/components/default_image_button.dart';
import 'package:hw_sport/ui/components/with_bottom_buttons.dart';
import 'package:hw_sport/ui/pages/progress_page.dart';
import 'package:hw_sport/util/convert_saved_statistic_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../states/question_state.dart';

class QuizPage extends StatefulWidget {
  final int questionNumber;
  final bool getTimeFromState;
  final bool isRetry;

  const QuizPage({
    super.key,
    required this.questionNumber,
    this.getTimeFromState = true,
    this.isRetry = false
  });

  @override
  State<StatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  double time = 60;
  int questionNumber = 1;
  int selectedAnswer = -1;
  bool sent = false;

  @override
  void initState() {
    super.initState();
    if (widget.getTimeFromState) {
      QuestionState currentQuestionState = Provider.of<QuestionState>(
          context, listen: false);
      time = currentQuestionState.time;
    }
    questionNumber = widget.questionNumber;
    startTimer();
  }

  Future<void> saveData() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    List<String>? savedStatisticData = shared.getStringList(sharedStatisticData);
    var converted = convertFromSavedStatisticData(savedStatisticData);
    int savedCorrectAnswers = converted[questionNumber - 1].$1;
    int savedIncorrectAnswers = converted[questionNumber - 1].$2;
    double savedAverageTimeToAnswer = converted[questionNumber - 1].$3;

    int savedAnswers = savedCorrectAnswers + savedIncorrectAnswers;

    savedAverageTimeToAnswer = ((savedAverageTimeToAnswer * savedAnswers) + (60 - time)) / (savedAnswers + 1);

    if (selectedAnswer == correctAnswers[questionNumber - 1]) {
      savedCorrectAnswers++;
    }
    else {
      savedIncorrectAnswers++;
    }

    converted[questionNumber-1] = (savedCorrectAnswers, savedIncorrectAnswers, savedAverageTimeToAnswer);

    var convertedAgain = convertToSavedStatisticData(converted);
    shared.setStringList(sharedStatisticData, convertedAgain);
  }

  Future<void> nextQuestion({void Function()? actionAfterSave}) async {
    await saveData();
    if (!widget.isRetry) {
      if (mounted) {
        QuestionState currentQuestionState = Provider.of<QuestionState>(
            context, listen: false);
        currentQuestionState.nextQuestion(questionNumber, selectedAnswer);
      }
      actionAfterSave?.call();
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        QuestionState currentQuestionState = Provider.of<QuestionState>(
            context, listen: false);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) {
              if (questionNumber < 20) {
                return QuizPage(questionNumber: questionNumber + 1,
                    getTimeFromState: false);
              }
              else {
                var currentAnswers = currentQuestionState.answers;
                return ProgressPage(
                  haveBackButton: false, currentAnswers: currentAnswers,);
              }
            })
        );
      }
    }
    else {
      if (mounted) {
        QuestionState currentQuestionState = Provider.of<QuestionState>(
            context, listen: false);
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
        }
        else {
          while(mounted && (ModalRoute.of(context)?.isCurrent ?? false)) {
            await Future.delayed(const Duration(milliseconds: 10));
          }
        }
        if (mounted && widget.getTimeFromState) {
          QuestionState currentQuestionState = Provider.of<QuestionState>(context, listen: false);
          currentQuestionState.setTime(time);
        }
      }
      else {
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
        selectedAnswer = correctAnswers[questionNumber - 1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: WithBottomButtons(
        pageEntity: PageEntityQuiz(questionNumber),
        inactiveButton: widget.isRetry ? 1 : -1,
          content: Padding(
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
                            child: Image.asset("res/images/time_icon.png",
                            width: 22,
                            height: 22,),
                          ),
                          LinearProgressIndicator(
                            backgroundColor: quizProgressBarBackgroundColor,
                            color: quizProgressBarColor,
                            value: time / 60,
                            minHeight: 13,
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                        child: Image.asset("res/images/cup.png", width: 38, height: 62,)
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 7.0),
                            child: Text("$questionNumber/20")
                          ),
                          LinearProgressIndicator(
                            backgroundColor: quizProgressBarBackgroundColor,
                            color: quizProgressBarColor,
                            value: questionNumber / 20,
                            minHeight: 13,
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
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
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 30),
                          child: Text(
                            questions[questionNumber-1],
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
                            text: answers[questionNumber - 1][i].substring(3),
                            selected: selectedAnswer == i && sent == false,
                            onSelected: !sent ? () {
                              setState(() {
                                selectedAnswer = i;
                              });
                            } : null,
                          ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 110, top: 50),
                            child: DefaultImageButton(
                            onPressed: selectedAnswer != -1 ? () {
                              setState(
                                      () {
                                    sent = true;
                                  }
                              );
                              nextQuestion();
                            } : null,
                            imageAsset: "res/images/submit_button.png"
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Color dependOnPicked(int answerNumber) {
    if (selectedAnswer == -1 || selectedAnswer != answerNumber) {
      return unselectedAnswerColor;
    }
    else if (sent) {
      if (selectedAnswer == correctAnswers[questionNumber-1]) {
        return correctAnswerColor;
      }
      else {
        return incorrectAnswerColor;
      }
    }
    else {
      return selectedAnswerColor;
    }
  }
}