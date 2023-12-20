enum QuizType {
  none,
  cricket,
  basketball,
  soccer;

  int toInt() {
    return switch(this) {
      none => -1,
      cricket => 0,
      basketball => 1,
      soccer => 2
    };
  }
}