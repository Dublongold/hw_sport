class ProgressEntity {
  final int questionNumber;
  final String? answer;
  final AnswerState answerState;

  ProgressEntity({
    required this.questionNumber,
    required this.answer,
    required this.answerState
  });
}

enum AnswerState {
  done,
  failed,
  timeExpired
}