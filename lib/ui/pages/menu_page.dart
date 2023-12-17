import 'package:flutter/material.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/ui/components/default_image_button.dart';
import 'package:hw_sport/ui/pages/privacy_policy_page.dart';
import 'package:hw_sport/ui/pages/quiz_page.dart';
import 'package:hw_sport/ui/pages/statistic_page.dart';
import 'package:provider/provider.dart';

import '../../states/question_state.dart';

class ButtonContainer {
  final String buttonAsset;
  final void Function() action;

  ButtonContainer(this.buttonAsset, this.action);
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  void navigateTo(BuildContext context, Widget destination) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => destination)
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonAssets = [
      ButtonContainer("res/images/continue_button.png", () {
        QuestionState currentQuestionState = Provider.of<QuestionState>(context, listen: false);
        navigateTo(context, QuizPage(questionNumber: currentQuestionState.questionNumber));
      }),
      ButtonContainer("res/images/new_quiz_button.png", () {
        navigateTo(context, const QuizPage(questionNumber: 1, getTimeFromState: false,));
      }),
      ButtonContainer("res/images/statistic_button.png", () {
        navigateTo(context, const StatisticPage());
      }),
      ButtonContainer("res/images/privacy_policy_button.png", () {
        navigateTo(context, const PrivacyPolicyPage());
      }),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final buttonAsset in buttonAssets)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: DefaultImageButton(
                    onPressed: buttonAsset.action,
                    imageAsset: buttonAsset.buttonAsset
                ),
              )
          ],
        ),
      ),
    );
  }

  void defaultOnClick() {}
}
