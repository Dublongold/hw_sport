import 'package:flutter/cupertino.dart';

class ButtonWithTwoImages extends StatefulWidget {
  final void Function()? action;
  final String imageAssetPressed;
  final String imageAssetUnpressed;
  final String disabledImageAsset;
  final bool isEnabled;

  const ButtonWithTwoImages({
    super.key,
    required this.isEnabled,
    required this.imageAssetPressed,
    required this.imageAssetUnpressed,
    required this.disabledImageAsset,
    required this.action,
  });

  @override
  State<ButtonWithTwoImages> createState() => _BottomButtonState();
}

class _BottomButtonState extends State<ButtonWithTwoImages> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.isEnabled ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
          onTap: widget.isEnabled ? widget.action : null,
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
          child: Image.asset(widget.isEnabled ? (isPressed
              ? widget.imageAssetPressed
              : widget.imageAssetUnpressed) : widget.disabledImageAsset)
      ),
    );
  }
}
