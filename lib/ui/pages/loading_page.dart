import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hw_sport/constants/arrays.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/constants/strings.dart';
import 'package:hw_sport/ui/components/button_with_two_images.dart';
import 'package:hw_sport/ui/pages/menu_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool dataLoaded = false;
  int currentBackgroundIndex = Random().nextInt(3);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        dataLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("res/images/background_loading_${currentBackgroundIndex + 1}.png", fit: BoxFit.fill),
          Center(
            child: FractionallySizedBox(
              heightFactor: 0.41,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      loadingTexts[currentBackgroundIndex].$1,
                      style: const TextStyle(
                          fontSize: 22,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    Text(
                      loadingTexts[currentBackgroundIndex].$2,
                      style: const TextStyle(
                          fontSize: 15
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (dataLoaded)
            Container(
                alignment:
                Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0.1),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 180,
                  ),
                  child: AspectRatio(
                    aspectRatio: 436 / 127,
                    child: ButtonWithTwoImages(
                        isEnabled: true,
                        imageAssetPressed: "res/images/button_next(pressed).png",
                        imageAssetUnpressed: "res/images/button_next.png",
                        disabledImageAsset: "res/images/button_next(pressed).png",
                        action: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const MenuPage())
                          );
                        },
                    ),
                  ),
                )
                /*
                DefaultImageButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const MenuPage())
                    );
                  },
                  imageAsset: "res/images/next_button.png",
                )
                 */
            )
          else
            Container(
                alignment:
                Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0.5),
                child: FractionallySizedBox(
                  widthFactor: 0.75,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(loadingString,
                          style: Theme.of(context).textTheme.bodyMedium),
                      const Padding(padding: EdgeInsets.all(5)),
                      const LinearProgressIndicator(
                        backgroundColor: loadingBarBackgroundColor,
                        color: loadingBarColor,
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        minHeight: 20,
                      )
                    ],
                  ),
                ))
        ],
      ),
    );
  }
}
