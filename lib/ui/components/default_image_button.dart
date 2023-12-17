import 'package:flutter/material.dart';

class DefaultImageButton extends StatelessWidget {
  const DefaultImageButton({
    super.key,
    required this.onPressed,
    required this.imageAsset,
    this.widthFactor = 0.8,
    this.heightFactor = 0.47
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 233,
      height: 67.5,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(imageAsset))
            ),
          ),
        ),
      ),
    );
  }

  final void Function()? onPressed;
  final String imageAsset;
  final double widthFactor;
  final double heightFactor;
}