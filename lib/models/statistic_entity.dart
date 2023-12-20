import 'package:hw_sport/models/quiz_types.dart';

class StatisticEntity {
  final QuizType quizType;
  final int questionNumber;
  final int answer;
  final AnswerState answerState;
  final void Function(bool) onPopInvoked;

  StatisticEntity({
    required this.quizType,
    required this.questionNumber,
    required this.answer,
    required this.answerState,
    required this.onPopInvoked
  });
}

enum AnswerState {
  done,
  failed,
  timeExpired
}