import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hw_sport/constants/arrays.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/constants/strings.dart';
import 'package:hw_sport/ui/components/button_with_two_images.dart';
import 'package:hw_sport/ui/pages/menu_page.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../constants/shared_preferences.dart';
import '../../util/webview_controller.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  int currentBackgroundIndex = Random().nextInt(3);

  bool dataLoaded = false;
  bool toNetwork = false;
  String urlToConnect = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    Logger().i("Start fetching.");
    SharedPreferences shared = await SharedPreferences.getInstance();
    String? url = shared.getString(sharedSavedUrl);
    if (url == null) {
      http.Request request = http.Request("Get", Uri.parse(mainUrlString))
        ..followRedirects = false;
      http.Client client = http.Client();
      var response = await client.send(request);
      if (response.isRedirect) {
        Logger().i("Redirect.");
        setState(() {
          String? location = response.headers["location"];
          if (location?.contains("policy") == true || location == null) {
            Logger().i("It's privacy policy...");
            dataLoaded = true;
          }
          else {
            Logger().i(
                "It's not privacy policy...${response.statusCode}, $location");
            dataLoaded = false;
            toNetwork = true;
            urlToConnect = location;
            shared.setString(sharedSavedUrl, location);
          }
        });
      }
      else {
        Logger().i("Not redirect...${response.statusCode}, ${response
            .headers["location"]}");
        setState(() {
          dataLoaded = true;
        });
      }
    }
    else {
      setState(() {
        urlToConnect = url;
        toNetwork = true;
        dataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (toNetwork) {
      return PopScope(
          onPopInvoked: (_) {
            controller.canGoBack().then((value) {
              if (value) {
                controller.goBack();
              }
            });
          },
          canPop: false,
          child: WebViewWidget(controller: controller..loadRequest(Uri.parse(urlToConnect)))
      );
    } else {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
                "res/images/background_loading_${currentBackgroundIndex +
                    1}.png", fit: BoxFit.fill),
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
                              MaterialPageRoute(builder: (
                                  context) => const MenuPage())
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium),
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
}
