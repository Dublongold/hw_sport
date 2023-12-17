import 'package:flutter/material.dart';

class QuestionState extends ChangeNotifier {
  int _questionNumber = 1;
  double _time = 60;
  List<int> _answers = [];

  int get questionNumber  => _questionNumber;
  double get time => _time;
  List<int> get answers => _answers;

  void nextQuestion(int questionNumber, int answer) {
    _time = 60;
    if (questionNumber < _questionNumber) {
      _answers = [answer];
      _questionNumber = questionNumber + 1;
    }
    else {
      _answers = [..._answers, answer];
      _questionNumber++;
    }
    notifyListeners();
  }

  void changeAnswer(int questionNumber, int answer) {
    _answers[questionNumber - 1] = answer;
  }

  void reset() {
    _time =  60;
    _answers = [];
    _questionNumber = 1;
  }


  void setTime(double time) {
    _time = time;
    notifyListeners();
  }

}