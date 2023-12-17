import 'package:flutter/material.dart';
import 'package:hw_sport/constants/numbers.dart';
import 'package:hw_sport/models/page_entity.dart';
import 'package:hw_sport/states/question_state.dart';
import 'package:hw_sport/ui/pages/progress_page.dart';
import 'package:provider/provider.dart';

class WithBottomButtons extends StatelessWidget {
  final Widget content;
  final int inactiveButton;
  final PageEntity pageEntity;

  const WithBottomButtons({
    super.key,
    required this.content,
    required this.pageEntity,
    this.inactiveButton = -1
  });


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        content,
        Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 375
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _BottomButton(
                    inactive: inactiveButton == 0,
                    imageAssetUnpressed: "res/images/home_button.png",
                    imageAssetPressed: "res/images/home_button(selected).png",
                    action: () {
                      if (pageEntity is PageEntityProgress) {
                        if((pageEntity as PageEntityProgress).answersCount == 20) {
                          QuestionState state = Provider.of(context, listen: false);
                          state.reset();
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          return;
                        }
                      }
                      Navigator.of(context).popUntil((route) => route.isFirst);
                }),
                _BottomButton(
                    inactive: inactiveButton == 1,
                    imageAssetUnpressed: "res/images/progress_button.png",
                    imageAssetPressed: "res/images/progress_button(selected).png",
                    action: () {
                      var answers = Provider.of<QuestionState>(context, listen: false).answers;
                      if (pageEntity is PageEntityQuiz) {
                        if ((pageEntity as PageEntityQuiz).questionNumber-1 < answers.length) {
                          answers = [];
                        }
                      }
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ProgressPage(currentAnswers: answers))
                      );
                }),
                _BottomButton(
                    inactive: inactiveButton == 2,
                    imageAssetUnpressed: "res/images/share_button.png",
                    imageAssetPressed: "res/images/share_button(selected).png",
                    action: () { }),
              ]
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
  final bool inactive;
  const _BottomButton({
    required this.inactive,
    required this.imageAssetPressed,
    required this.imageAssetUnpressed,
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
          aspectRatio: 678 / 582,
          child: MouseRegion(
            cursor: widget.inactive ? MouseCursor.defer : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: !widget.inactive ? widget.action : null,
              onTapDown: (_) {
                setState(() {
                  isPressed = true;
                });
              },
                onPanStart: (_) {
                  setState(() {
                    isPressed = true;
                  });
                },
                onPanEnd: (_) {
                  setState(() {
                    isPressed = false;
                  });
                },
                onTapUp: (_) {
                setState(() {
                  isPressed = false;
                });
                },
                child: Image.asset(isPressed || widget.inactive ? widget.imageAssetPressed : widget.imageAssetUnpressed)
            ),
          ),
        ),
      ),
    );
  }
}