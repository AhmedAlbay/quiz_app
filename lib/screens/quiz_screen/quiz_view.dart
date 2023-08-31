import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/quiz_controller.dart';
import 'package:quiz_app/widgets/custom_button.dart';
import 'package:quiz_app/widgets/progress_timer.dart';
import 'package:quiz_app/widgets/question_card.dart';

class QuizView extends StatelessWidget {
  const QuizView({Key? key}) : super(key: key);
  static const routeName = '/quiz_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.black87),
          ),
          SafeArea(
            child: GetBuilder<QuizController>(
              init: QuizController(),
              builder: (controller) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'Question ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                              children: [
                                TextSpan(
                                    text: controller.numberOfQuestion
                                        .round()
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(color: Colors.white)),
                                TextSpan(
                                    text: '/',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: Colors.white)),
                                TextSpan(
                                    text: controller.countOfQuestion.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: Colors.white)),
                              ]),
                        ),
                        ProgressTimer(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 450,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => QuestionCard(
                        questionModel: controller.questionsList[index],
                      ),
                      controller: controller.pageController,
                      itemCount: controller.questionsList.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: GetBuilder<QuizController>(
        init: QuizController(),
        builder: (controller) => CustomButton(
            onPressed: () => controller.nextQuestion(), text: 'Next'),
      ),
    );
  }
}
