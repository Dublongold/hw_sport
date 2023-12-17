class StatisticEntity {
  final String text;
  final int numberOfCorrectAnswers;
  final int numberOfIncorrectAnswers;
  final double averageTimeToAnswer;

  StatisticEntity({
    required this.text,
    required this.numberOfCorrectAnswers,
    required this.numberOfIncorrectAnswers,
    required this.averageTimeToAnswer,
  });
}