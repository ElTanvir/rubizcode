import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latext/latext.dart';
import 'package:my_app/core/extensions/extensions.dart';
import 'package:my_app/core/router/router.dart';
import 'package:my_app/core/ui/widgets/app_button.dart';
import 'package:my_app/core/utils/toast.dart';
import 'package:my_app/feature/quiz/presentation/riverpod/quiz_game_provider.dart';
import 'package:my_app/feature/quiz/presentation/widgets/quiz_option_widget.dart';
import 'package:my_app/feature/quiz/presentation/widgets/quiz_timer_widget.dart';
import 'package:my_app/feature/quiz/presentation/widgets/swap_animation.dart';

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  int? selectedItemID;
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(quizGameProvider.notifier).initiateGame(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizGameState = ref.watch(quizGameProvider);
    final quizGameNotifier = ref.read(quizGameProvider.notifier);
    final question = quizGameState.currentQuestion;
    ref.listen(
      quizGameProvider,
      (previous, next) {
        if (previous != null &&
            previous.currentQuestionIndex != next.currentQuestionIndex) {
          selectedItemID = null;
        }
      },
    );
    final appBarTitle = question == null
        ? 'Quiz Game'
        : 'Question ${quizGameState.currentQuestionIndex + 1}/${quizGameState.questions.length}';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            appBarTitle,
            style: context.texts.headline6.copyWith(
              color: context.appTheme.onPrimary,
            ),
          ),
        ),
        body: question != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: quizGameState.currentQuestionIndex /
                        (quizGameState.questions.length - 1),
                    backgroundColor: context.appTheme.primary,
                    color: context.appTheme.success,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            20.ph, // Spacer
                            Center(
                              child: QuizTimerWidget(
                                value: quizGameState.secondsRemaining,
                              ),
                            ),
                            20.ph, //pacer
                            SwapAnimation(
                              child: LaTexT(
                                key: ValueKey(
                                  question.question,
                                ),
                                laTeXCode: Text(
                                  question.question,
                                  style: context.texts.subtitle1,
                                ),
                              ),
                            ),
                            20.ph, //Spacer
                            ...question.options.asMap().entries.map(
                              (item) {
                                final option = item.value;
                                return SwapAnimation(
                                  child: QuizOptionWidget(
                                    key: ValueKey(
                                      option,
                                    ),
                                    value: option,
                                    isSelected: selectedItemID == item.key,
                                    onTap: () {
                                      if (selectedItemID != null) {
                                        Toast.showError(
                                          context,
                                          "You can't change selection",
                                        );
                                        return;
                                      } else {
                                        setState(() {
                                          selectedItemID = item.key;
                                        });
                                      }
                                    },
                                    hasBottomPadding:
                                        item.key < question.options.length,
                                  ),
                                );
                              },
                            ),
                            20.ph,
                            AppButton.filled(
                              label: quizGameState.isLastQuestion
                                  ? 'Finish'
                                  : 'Next',
                              onPressed: () {
                                if (quizGameState.isLastQuestion) {
                                  context
                                      .pushReplacementNamed(Routes.quizFinish);
                                } else if (selectedItemID != null) {
                                  quizGameNotifier.answerQuestion(
                                    selectedItemID,
                                  );
                                } else {
                                  Toast.showError(
                                    context,
                                    'Please select an option',
                                  );
                                }
                              },
                            ),
                            20.ph,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const Text("Couldn't Get Question"),
      ),
    );
  }
}
