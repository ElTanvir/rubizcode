import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/extensions/extensions.dart';
import 'package:my_app/core/router/router.dart';
import 'package:my_app/core/ui/widgets/app_button.dart';
import 'package:my_app/core/utils/toast.dart';
import 'package:my_app/feature/quiz/presentation/riverpod/leader_board_provider.dart';
import 'package:my_app/feature/quiz/presentation/riverpod/quiz_game_provider.dart';
import 'package:my_app/feature/quiz/presentation/widgets/quirz_results.dart';

class QuizFinishPage extends ConsumerStatefulWidget {
  const QuizFinishPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizFinishPageState();
}

class _QuizFinishPageState extends ConsumerState<QuizFinishPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final gameState = ref.read(quizGameProvider);
      if (gameState.hasPassed) {
        Confetti.launch(
          context,
          options: const ConfettiOptions(
            particleCount: 100,
            spread: 70,
            y: 0.6,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizGameState = ref.watch(quizGameProvider);
    final leaderBoardNotifier = ref.read(leaderBoardProvider.notifier);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Quiz Finish',
            style: context.texts.headline6.copyWith(
              color: context.appTheme.onPrimary,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 0.6.sw,
                    width: 0.6.sw,
                    child: QuizResultAnimation(
                      hasPassed: quizGameState.hasPassed,
                    ),
                  ),
                  Text(
                    'Questions: ${quizGameState.maxScore}'
                    '\nCorrect: ${quizGameState.totalScore}',
                    style: context.texts.headline4,
                  ),
                ],
              ),
              Column(
                children: [
                  20.ph,
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: context.inputDecor
                              .outlinedInputDecor(hint: 'Enter Your Name'),
                        ),
                      ),
                      10.pw,
                      SizedBox(
                        width: 0.3.sw,
                        child: AppButton.filled(
                          label: 'Save',
                          onPressed: () {
                            final name = _nameController.text.trim();
                            if (name.isNotEmpty) {
                              leaderBoardNotifier.saveScore(
                                name: name,
                                score: quizGameState.totalScore,
                              );
                              Navigator.pop(context);
                            } else {
                              Toast.showError(context, "Name Can't be Empty");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  20.ph,
                  AppButton.filled(
                    label: 'Play Again',
                    onPressed: () {
                      context.pushReplacementNamed(Routes.quiz);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
