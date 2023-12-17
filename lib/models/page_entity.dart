interface class PageEntity {

}

class PageEntityQuiz implements PageEntity {
  final int questionNumber;
  PageEntityQuiz(this.questionNumber);
}

class PageEntityProgress implements PageEntity {
  final int answersCount;
  PageEntityProgress(this.answersCount);
}