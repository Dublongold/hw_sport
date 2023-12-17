import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import '../../constants/colors.dart';
import '../../constants/strings.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  String privacyPolicyText = startingPrivacyPolicyTextString;

  @override
  void initState() {
    super.initState();
    fetchPrivacyPolicyText();
  }

  Future fetchPrivacyPolicyText() async {
    try {
      final response = await http.get(Uri.parse(privacyPolicyUrlString));
      setState(() {
        privacyPolicyText =
        (response.statusCode == 200 ? response.body : badResponseString);
      });
    }
    on Exception {
      setState(() {
        privacyPolicyText = badResponseString;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(padding: EdgeInsets.only(top: 40)),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 15.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                iconSize: 32,
                highlightColor: Colors.white12,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Html(data: privacyPolicyText)
                      ),
                      if (privacyPolicyText == startingPrivacyPolicyTextString)
                        const CircularProgressIndicator()
                    ]
                  )
              )
          ),
        ]));
  }
}
/*
switch(privacyPolicyUrl) {
      startingPrivacyPolicyText => const Placeholder(),
      String() => const Placeholder(),
    };
 */
