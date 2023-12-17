import 'package:flutter/material.dart';
import 'package:hw_sport/constants/colors.dart';
import 'package:hw_sport/constants/shared_preferences.dart';
import 'package:hw_sport/constants/strings.dart';
import 'package:hw_sport/ui/components/default_image_button.dart';
import 'package:hw_sport/ui/pages/menu_page.dart';
import 'package:http/http.dart' as http;
import 'package:hw_sport/util/web_view.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
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
          if (location == privacyPolicyUrlString || location == null) {
            Logger().i("It's privacy policy...");
            dataLoaded = true;
          }
          else {
            Logger().i(
                "It's not privacy policy...${response.statusCode}, $location");
            dataLoaded = false;
            toNetwork = true;
          }
          shared.setString(sharedSavedUrl, location!);
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
    return toNetwork ? WebViewWidget(controller: controller..loadRequest(Uri.parse(urlToConnect))) :
    Stack(
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
