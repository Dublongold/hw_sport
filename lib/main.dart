import 'package:flutter/material.dart';
import 'package:hw_sport/constants/strings.dart';
import 'package:hw_sport/states/question_state.dart';
import 'package:hw_sport/ui/pages/loading_page.dart';
import 'package:provider/provider.dart';

import 'constants/theme_data.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
          create: (context) => QuestionState(),
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appNameString,
        theme: themeData,
        home: const LoadingPage(),
      ),
    );
  }
}
