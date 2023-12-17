const List<String> questions = [
  "1. Who is the highest run-scorer in One Day Internationals (ODIs) for South Africa?",
  "2. Which South African cricketer has the highest individual score in Test cricket?",
  "3. What is the nickname of the South African national cricket team?",
  "4. Which South African bowler has taken the most wickets in Test cricket?",
  "5. In which year did South Africa win its first ICC Cricket World Cup title?",
  "6. Who was the captain of the South African cricket team during the 2019 ICC Cricket World Cup?",
  "7. Which South African cricketer holds the record for the fastest century in One Day Internationals?",
  "8. What is the home ground of the South African national cricket team in Test matches?",
  "9. Which South African cricketer is known as the \"White Lightning\" due to his fast bowling?",
  "10. Who was the first South African cricketer to score 10,000 runs in Test matches?",
  "11. Which South African cricketer has the most number of centuries in Test matches?",
  "12. In which year did South Africa return to international cricket after the end of apartheid?",
  "13. Who was the first South African bowler to take 10 wickets in a Test match?",
  "14. Which South African cricketer has the highest individual score in One Day Internationals?",
  "15. Who was the first South African cricketer to score a double century in Test matches?",
  "16. Which South African cricketer is known for his unorthodox bowling action and is nicknamed \"Tahir's Googley\"?",
  "17. Who is the current captain of the South African national cricket team in Test matches?",
  "18. Which South African cricketer has the most number of wickets in T20 International matches?",
  "19. In which year did South Africa host its first-ever Test match after readmission to international cricket?",
  "20. Who was the first South African cricketer to score a century in T20 International matches?",
];

const List<List<String>> answers = [
  ["A) Jacques Kallis", "B) AB de Villiers", "C) Herschelle Gibbs", "D) Graeme Smith"],
  ["A) Hashim Amla", "B) Gary Kirsten", "C) AB de Villiers", "D) Jacques Kallis"],
  ["A) Proteas", "B) Springboks", "C) Bafana Bafana", "D) The Lions"],
  ["A) Dale Steyn", "B) Shaun Pollock", "C) Makhaya Ntini", "D) Allan Donald"],
  ["A) 1992", "B) 1996", "C) 1999", "D) 2003"],
  ["A) Faf du Plessis", "B) AB de Villiers", "C) Hashim Amla", "D) Quinton de Kock"],
  ["A) AB de Villiers", "B) Hashim Amla", "C) Quinton de Kock", "D) Herschelle Gibbs"],
  ["A) Newlands, Cape Town", "B) Wanderers Stadium, Johannesburg", "C) Kingsmead, Durban", "D) SuperSport Park, Centurion"],
  ["A) Dale Steyn", "B) Allan Donald", "C) Shaun Pollock", "D) Morne Morkel"],
  ["A) Jacques Kallis", "B) Graeme Smith", "C) Hashim Amla", "D) AB de Villiers"],
  ["A) Jacques Kallis", "B) Hashim Amla", "C) Graeme Smith", "D) AB de Villiers"],
  ["A) 1988", "B) 1991", "C) 1992", "D) 1994"],
  ["A) Hugh Tayfield", "B) Allan Donald", "C) Makhaya Ntini", "D) Dale Steyn"],
  ["A) Faf du Plessis", "B) Hashim Amla", "C) Gary Kirsten", "D) AB de Villiers"],
  ["A) Jacques Kallis", "B) Graeme Smith", "C) Hashim Amla", "D) AB de Villiers"],
  ["A) Imran Tahir", "B) Paul Adams", "C) Robin Peterson", "D) Johan Botha"],
  ["A) Dean Elgar", "B) Quinton de Kock", "C) Faf du Plessis", "D) Kagiso Rabada"],
  ["A) Dale Steyn", "B) Imran Tahir", "C) Morne Morkel", "D) Kagiso Rabada"],
  ["A) 1992", "B) 1994", "C) 1995", "D) 1996"],
  ["A) AB de Villiers", "B) Herschelle Gibbs", "C) Faf du Plessis", "D) Quinton de Kock"],
];

List<int> correctAnswers = [1, 2, 0, 1, 2, 0, 0, 0, 1, 0, 0, 3, 0, 3, 0, 1, 0, 0, 0, 1, 2];

List<String> optionImages = [
  "res/images/option_a.png",
  "res/images/option_b.png",
  "res/images/option_c.png",
  "res/images/option_d.png",
];