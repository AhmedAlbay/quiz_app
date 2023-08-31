import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/screens/result_screen/result_view.dart';
import 'package:quiz_app/screens/home_view.dart';

class QuizController extends GetxController {
  String name = '';

  int get countOfQuestion => _questionsList.length;
  final List<QuestionModel> _questionsList = [

  
   QuestionModel(
      id: 1,
      question: "What is Flutter?",
      answer:2,
      options: ["Programming language", "Operating system", "UI framework", "Database"],
    ),
    QuestionModel(
      id: 2,
      question: "What language is Flutter based on?",
      answer: 3,
      options: ["Java", "Python", "C#", "Dart"],
    ),
    QuestionModel(
      id: 3,
      question: "What widget is used to create a text input field in Flutter?",
      answer: 3,
      options: ["Text", "TextInput", "EditText", "TextField"],
    ),
    QuestionModel(
      id: 4,
      question: "What's the purpose of the 'setState' method in Flutter?",
      answer: 1,
      options: ["Trigger animations", "Update the UI", "Handle HTTP requests", "Navigate between screens"],
    ),
    QuestionModel(
      id: 5,
      question: "Which widget is used for laying out items linearly in Flutter?",
      answer: 3,
      options: ["Grid", "Row", "Stack", "Column"],
    ),
    QuestionModel(
      id: 6,
      question: "What's the main benefit of using a stateless widget in Flutter?",
      answer: 2,
      options: ["Faster compilation", "Richer UI", "Performanceoptimization", "Easier debugging"],
    ),
    QuestionModel(
      id: 7,
      question: "What does 'hot reload' mean in Flutter?",
      answer: 2,
      options: ["Turning off the device", "Creating a new project", "App updates without ", "Adding new packages"],
    ),
    QuestionModel(
      id: 8,
      question: "Which data type is used for asynchronous operations in Dart?",
      answer: 1,
      options: ["Promise", "Future", "Task", "Callback"],
    ),
    QuestionModel(
      id: 9, 
      question: "What's the purpose of the 'main()' function in Dart?",
      answer:3,
      options: ["Printing output", "Defining variables", "Creating widgets", "Entry point "],
    ),
    QuestionModel(
      id: 10,
      question: "What's the keyword used to create a new instance of a class in Dart?",
      answer: 3,
      options: ["instance", "class", "create", "new"],
    ),
  ];

  List<QuestionModel> get questionsList => [..._questionsList];

  bool _isPressed = false;

  bool get isPressed => _isPressed; 

  double _numberOfQuestion = 1;

  double get numberOfQuestion => _numberOfQuestion;

  int? _selectAnswer;

  int? get selectAnswer => _selectAnswer;

  int? _correctAnswer;

  int _countOfCorrectAnswers = 0;

  int get countOfCorrectAnswers => _countOfCorrectAnswers;

  
  final Map<int, bool> _questionIsAnswerd = {};

  late PageController pageController;

  
  Timer? _timer;

  final maxSec = 15;

  final RxInt _sec = 15.obs;

  RxInt get sec => _sec;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }


  double get scoreResult {
    return _countOfCorrectAnswers * 100 / _questionsList.length;
  }

  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;

    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;

    if (_correctAnswer == _selectAnswer) {
      _countOfCorrectAnswers++;
    }
    stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => nextQuestion());
    update();
  }

 
  bool checkIsQuestionAnswered(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  void nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }

    if (pageController.page == _questionsList.length - 1) {
      Get.offAndToNamed(ResultView.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      startTimer();
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }

 
  void resetAnswer() {
    for (var element in _questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

 
  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return Colors.white;
  }


  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value > 0) {
        _sec.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void resetTimer() => _sec.value = maxSec;

  void stopTimer() => _timer!.cancel();

  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    resetAnswer();
    _selectAnswer = null;
    Get.offAllNamed(HomeView.routeName);
  }
}
