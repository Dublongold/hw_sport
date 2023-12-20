import 'package:flutter/material.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/models/quiz_types.dart';
import 'package:hw_sport/states/quiz_state.dart';
import 'package:hw_sport/ui/components/with_bottom_buttons.dart';
import 'package:hw_sport/ui/pages/quiz_page.dart';
import 'package:provider/provider.dart';

import '../../models/button_container.dart';



class MenuPage extends StatelessWidget {
  final int questionNumber;
  final QuizType quizType;
  final bool isOver;
  const MenuPage({
    super.key,
    this.quizType = QuizType.none,
    this.questionNumber = -1,
    this.isOver = true
  });

  void _navigateToQuiz(BuildContext context, QuizType quizType) {
    Provider.of<QuizState>(context, listen: false).startQuiz(quizType);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => QuizPage(quizType: quizType))
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonAssets = [
      ButtonContainer("res/images/button_cricket_quiz.png", () {
        _navigateToQuiz(context, QuizType.cricket);
      }),
      ButtonContainer("res/images/button_basketball_quiz.png", () {
        _navigateToQuiz(context, QuizType.basketball);
      }),
      ButtonContainer("res/images/button_soccer_quiz.png", () {
        _navigateToQuiz(context, QuizType.soccer);
      }),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: WithBottomButtons(
        disabledButton: 0,
        child: Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1,),
              for (final buttonAsset in buttonAssets)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 400
                    ),
                    child: FractionallySizedBox(
                      widthFactor: 0.85,
                      child: AspectRatio(
                        aspectRatio: 724 / 220,
                        child: IconButton(
                            onPressed: buttonAsset.action,
                            padding: EdgeInsets.zero,
                            icon: Image.asset(buttonAsset.buttonAsset)
                        ),
                      ),
                    ),
                  ),
                ),
              const Spacer(flex: 2,)
            ],
          ),
        ),
      ),
    );
  }
}
