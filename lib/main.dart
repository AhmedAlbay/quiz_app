import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/quiz_screen/quiz_view.dart';
import 'package:quiz_app/screens/result_screen/result_view.dart';
import 'package:quiz_app/screens/home_view.dart';
import 'package:quiz_app/util/bindings_app.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialBinding: BilndingsApp(),
      title: 'Quiz App',
      home: HomeView(),
      getPages: [
        GetPage(name: HomeView.routeName, page: () => HomeView()),
        GetPage(name: QuizView.routeName, page: () => QuizView()),
        GetPage(name: ResultView.routeName, page: () => ResultView()),
      ],
    );
  }
}
