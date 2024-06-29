import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:lesson_65/controllers/quiz_controller.dart';
import 'package:lesson_65/models/quiz.dart';
import 'package:lesson_65/views/widgets/custom_drawer.dart';
import 'package:lesson_65/views/widgets/question_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final quizController = context.watch<QuizController>();

    return Scaffold(
      key: _key,
      backgroundColor: const Color(0xff7b7bce),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: quizController.list,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("Mahsulotlar mavjud emas"),
                  );
                }

                final questions = snapshot.data!.docs;

                return PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    final question = Quiz.fromJson(questions[index]);

                    return QuestionCard(
                      questions: questions,
                      question: question,
                      pageController: _pageController,
                      index: index,
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: Animate()
                .custom(
                  duration: 500.milliseconds,
                  begin: 10,
                  end: 0,
                  builder: (context, value, child) => GestureDetector(
                    onTap: () {
                      _key.currentState!.openDrawer();
                    },
                    child: Image.asset(
                      "assets/icons/face.gif",
                      width: 60,
                    ),
                  ),
                )
                .slideX(begin: 0.10, end: 0)
                .fadeIn(),
          ),

          Positioned(
            bottom: 40,
            right: 10,
            child: Animate()
                .custom(
                  duration: 500.milliseconds,
                  begin: 10,
                  end: 0,
                  builder: (_, value, __) => Column(
                    children: [
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.4),
                        ),
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_drop_up_rounded,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                      const Gap(10.0),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.4),
                        ),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
                .slideY(begin: 0.20, end: 0.0)
                .fadeIn(),
          ),
          // Lottie.asset('assets/images/congrulation.json'),
        ],
      ),
    );
  }
}
