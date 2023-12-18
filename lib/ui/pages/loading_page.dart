import 'package:flutter/material.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/constants/strings.dart';
import 'package:hw_sport/ui/components/default_image_button.dart';
import 'package:hw_sport/ui/pages/menu_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool dataLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState((){dataLoaded = true;}));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset("res/images/loading_background.png", fit: BoxFit.fill),
        if (dataLoaded)
          Container(
              alignment:
              Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0.3),
              child: DefaultImageButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MenuPage())
                  );
                },
                imageAsset: "res/images/start_button.png",
              ))
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
    );
  }
}
