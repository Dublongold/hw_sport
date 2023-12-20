import 'package:flutter/material.dart';
import 'package:hw_sport/models/quiz_types.dart';

class QuizState extends ChangeNotifier {
  List<int> _answers = [];
  QuizType _quizType = QuizType.none;

  List<int> get answers => _answers;
  QuizType get quizType => _quizType;

  void nextQuestion(int answer) {
    _answers = [..._answers, answer];
    notifyListeners();
  }

  void startQuiz(QuizType quizType) {
    _quizType = quizType;
    _answers = [];
  }

  void changeAnswer(int questionIndex, int answer) {
    _answers[questionIndex] = answer;
  }
}