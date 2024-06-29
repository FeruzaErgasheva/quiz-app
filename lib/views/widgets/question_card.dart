import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:lesson_65/controllers/select_controller.dart';
import 'package:lesson_65/models/quiz.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class QuestionCard extends StatefulWidget {
  final List<QueryDocumentSnapshot<Object?>> questions;
  final Quiz question;
  final PageController pageController;
  final int index;
  const QuestionCard({
    super.key,
    required this.questions,
    required this.question,
    required this.pageController,
    required this.index,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int n = 0;
  void dialog(int n) {
    bool showText = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(milliseconds: 2100), () {
          showText = true;
          (context as Element).markNeedsBuild();
        });

        return StatefulBuilder(
          builder: (context, setState) {
            int n = context.read<SelectController>().answerCount;
            return AlertDialog(
              title: const Text('Congratulations!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  showText
                      ? Lottie.asset('assets/images/congrulation.json')
                      : Lottie.asset('assets/images/check.json'),
                  if (showText)
                    Text(
                        "Siz ${widget.questions.length} dan $n ga to'g'ri javob berdingiz"),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectController = context.watch<SelectController>();
    final selectedOption = selectController.selectedOption;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(MediaQuery.of(context).size.height / 4),
        Animate()
            .custom(
              builder: (context, value, child) => Text(
                widget.question.question,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
            .slideY(begin: 0, end: 0.4)
            .fadeIn(),
        const Gap(20.0),
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.question.options.length,
            separatorBuilder: (context, index) => const Gap(20.0),
            itemBuilder: (context, optionIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    context.read<SelectController>().selectOption(
                          widget.index,
                          widget.question.options[optionIndex],
                          optionIndex == widget.question.correct,
                        );

                    if (widget.index == widget.questions.length - 1) {
                      dialog(n);
                    } else {
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear,
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: selectedOption[widget.index] ==
                              widget.question.options[optionIndex]
                          ? Colors.green.withOpacity(0.7)
                          : Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        selectedOption[widget.index] ==
                                widget.question.options[optionIndex]
                            ? const BoxShadow(
                                color: Colors.transparent,
                              )
                            : BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(5, 6),
                                blurRadius: 4,
                              ),
                      ],
                    ),
                    child: Text(
                      widget.question.options[optionIndex],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
