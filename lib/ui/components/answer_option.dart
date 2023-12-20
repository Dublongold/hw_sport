import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final Color color;
  final String imageAsset;
  final String text;
  final bool selected;
  final void Function()? onSelected;

  const AnswerOption({
    super.key,
    required this.color,
    required this.imageAsset,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 30),
      child: MouseRegion(
        cursor: onSelected != null ? SystemMouseCursors.click : MouseCursor.defer,
        child: GestureDetector(
          onTap: onSelected,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 60
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: color
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      height: 38,
                      child: AspectRatio(
                          aspectRatio: 264/225,
                          child: Image.asset(imageAsset),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 38,
                      child: AspectRatio(
                          aspectRatio: 264/225,
                          child: selected ? Image.asset(
                            "res/images/selected_answer.png",
                          ) : Container()
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}