import 'package:hw_sport/models/quiz_types.dart';

interface class PageEntity {

}


class PageEntityMenu implements PageEntity {
  final int questionNumber;
  final QuizType quizType;
  final bool isOver;
  PageEntityMenu({
    required this.questionNumber,
    required this.quizType,
    required this.isOver
  });
}

class PageEntityQuiz implements PageEntity {
  final int questionNumber;
  final int quizType;
  PageEntityQuiz(
      this.questionNumber,
      this.quizType,
      );
}

class PageEntityStatistic implements PageEntity {
  final int answersCount;
  PageEntityStatistic(this.answersCount);
}