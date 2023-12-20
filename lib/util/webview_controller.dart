import 'package:hw_sport/constants/colors.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

extension TestExtention on WebViewController {
  Future<void> removeDefaultUserAgent() async {
    setUserAgent((await getUserAgent())?.replaceAll("wv ;", ""));
  }
}

var controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(backgroundColor)
  ..removeDefaultUserAgent()
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        Logger().i("Progress: $progress");
      },
      onPageStarted: (String url) {
        Logger().i("Started: $url");
      },
      onPageFinished: (String url) {
        Logger().i("Finished: $url");
      },
      onWebResourceError: (WebResourceError error) {
        Logger().i("Error: ${error.errorCode}, ${error.url}, ${error.description}");
      },
      onNavigationRequest: (NavigationRequest request) {
        Logger().i("Navigate to: ${request.url}");
        return NavigationDecision.navigate;
      },
    ),
  );