import 'package:flutter/material.dart';
import 'package:hw_sport/constants/numbers.dart';
import 'package:hw_sport/states/quiz_state.dart';
import 'package:hw_sport/ui/components/button_with_two_images.dart';
import 'package:hw_sport/ui/pages/setting_page.dart';
import 'package:hw_sport/ui/pages/statistic_page.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';

class WithBottomButtons extends StatelessWidget {
  final Widget child;
  final int disabledButton;

  const WithBottomButtons({
    super.key,
    required this.child,
    this.disabledButton = -1
  });


  @override
  Widget build(BuildContext context) {
    const backgroundRadius = Radius.circular(32);
    return Stack(
      children: [
        child,
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: backgroundRadius, topRight: backgroundRadius),
              color: bottomBarBackgroundColor
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 375
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _BottomButton(
                        isEnabled: disabledButton != 0,
                        imageAssetUnpressed: "res/images/button_menu.png",
                        imageAssetPressed: "res/images/button_menu(pressed).png",
                        disabledImageAsset: "res/images/button_menu(pressed).png",
                        action: () {
                            Navigator.of(context).pop();
                        }
                    ),
                    _BottomButton(
                        isEnabled: disabledButton != 1,
                        imageAssetUnpressed: "res/images/button_statistic.png",
                        imageAssetPressed: "res/images/button_statistic(pressed).png",
                        disabledImageAsset: "res/images/button_statistic(pressed).png",
                        action: () {
                          var quizType = Provider.of<QuizState>(context, listen: false).quizType;
                          var route = MaterialPageRoute(builder: (_) => StatisticPage(quizType: quizType));
                          if (disabledButton == 2) {
                            Navigator.of(context).pushReplacement(route);
                          }
                          else {
                            Navigator.of(context).push(route);
                          }
                    }),
                    _BottomButton(
                        isEnabled: disabledButton != 2,
                        imageAssetUnpressed: "res/images/button_setting.png",
                        imageAssetPressed: "res/images/button_setting(pressed).png",
                        disabledImageAsset: "res/images/button_setting(pressed).png",
                        action: () {
                          var route = MaterialPageRoute(builder: (_) => const SettingPage());
                          if (disabledButton == 1) {
                            Navigator.of(context).pushReplacement(route);
                          }
                          else {
                            Navigator.of(context).push(route);
                          }
                        }),
                  ]
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomButton extends StatefulWidget {
  final void Function() action;
  final String imageAssetPressed;
  final String imageAssetUnpressed;
  final String disabledImageAsset;
  final bool isEnabled;

  const _BottomButton({
    required this.isEnabled,
    required this.imageAssetPressed,
    required this.imageAssetUnpressed,
    required this.disabledImageAsset,
    required this.action,
  });

  @override
  State<_BottomButton> createState() => _BottomButtonState();
}

class _BottomButtonState extends State<_BottomButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            maxWidth: bottomButtonWidth,
            maxHeight: bottomButtonHeight
        ),
        child: AspectRatio(
          aspectRatio: 158 / 135,
          child: ButtonWithTwoImages(
              isEnabled: widget.isEnabled,
              imageAssetPressed: widget.imageAssetPressed,
              imageAssetUnpressed: widget.imageAssetUnpressed,
              disabledImageAsset: widget.disabledImageAsset,
              action: widget.action
          )
        ),
      ),
    );
  }
}