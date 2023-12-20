// 1) Array with questions
List<String> questions = [
  "1. In cricket, what is the term for a batsman being declared out without scoring any runs?",
  "2. How many players are there in a standard cricket team?",
  "3. Which country won the ICC Cricket World Cup in 2019?",
  "4. What is the maximum number of runs a batsman can score off one ball without overthrows?",
  "5. In cricket, what is the term for a delivery that reaches the batsman without bouncing?",
  "6. Who holds the record for the highest individual score in Test cricket?",
  "7. What is the name of the trophy awarded to the winner of the Ashes series between England and Australia?",
  "8. Which cricket format is known for matches lasting up to five days?",
  "9. What is the term for the area of the field where a batsman stands and attempts to hit the ball?",
  "10. In a limited-overs match, what is the maximum number of overs each team can bowl?",
  "11. Who is the all-time leading run-scorer in One Day Internationals (ODIs)?",
  "12. What is the term for a bowler taking three wickets on three consecutive deliveries?",
  "13. In cricket, what is the term for the protective gear worn by batsmen to prevent injury?",
  "14. Who is known as the 'Sultan of Swing' in cricket?",
  "15. What is the term for a batsman getting out without facing a ball in an innings?",
  "16. Which country hosted the first-ever Cricket World Cup in 1975?",
  "17. What is the name of the international governing body for cricket?",
  "18. How many fielding players are allowed outside the 30-yard circle during the non-powerplay overs in a One Day International (ODI) match?",
  "19. What is the term for a delivery that spins sharply from the leg side to the off side, typically bowled by a leg-spinner?",
  "20. Who holds the record for the most sixes in international cricket?",
];

// 2) Array with arrays that contain possible answers
List<List<String>> answers = [
  ["A) Duck", "B) Wicket", "C) Yorker", "D) Boundary"],
  ["A) 9", "B) 11", "C) 13", "D) 15"],
  ["A) Australia", "B) India", "C) England", "D) South Africa"],
  ["A) 4", "B) 6", "C) 8", "D) 10"],
  ["A) Yorker", "B) Full toss", "C) Bouncer", "D) Googly"],
  ["A) Ricky Ponting", "B) Brian Lara", "C) Sachin Tendulkar", "D) Hanif Mohammad"],
  ["A) The Urn", "B) The Shield", "C) The Cup", "D) The Ashes"],
  ["A) T20", "B) Test", "C) One Day International (ODI)", "D) The Hundred"],
  ["A) Square leg", "B) Crease", "C) Gully", "D) Silly mid-on"],
  ["A) 40", "B) 50", "C) 60", "D) 70"],
  ["A) Ricky Ponting", "B) Sachin Tendulkar", "C) Virat Kohli", "D) AB de Villiers"],
  ["A) Hat-trick", "B) Yorker", "C) Golden duck", "D) Maiden over"],
  ["A) Gloves", "B) Pads", "C) Helmet", "D) Chest guard"],
  ["A) Glenn McGrath", "B) Wasim Akram", "C) James Anderson", "D) Curtly Ambrose"],
  ["A) Run-out", "B) Golden duck", "C) Stumped", "D) LBW (Leg Before Wicket)"],
  ["A) England", "B) Australia", "C) West Indies", "D) India"],
  ["A) ICC (International Cricket Council)", "B) MCC (Marylebone Cricket Club)", "C) BCCI (Board of Control for Cricket in India)", "D) ECB (England and Wales Cricket Board)"],
  ["A) 4", "B) 5", "C) 6", "D) 7"],
  ["A) Googly", "B) Off-cutter", "C) Leg break", "D) Doosra"],
  ["A) Chris Gayle", "B) AB de Villiers", "C) Rohit Sharma", "D) Shahid Afridi"],
];


// 3) Array with indices with correct answers
List<int> correctAnswers = [0, 1, 2, 0, 1, 2, 2, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 2, 2];