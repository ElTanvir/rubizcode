import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/extensions/extensions.dart';
import 'package:my_app/core/router/router.dart';
import 'package:my_app/core/ui/theme.dart';
import 'package:my_app/core/ui/widgets/app_button.dart';
import 'package:my_app/feature/app/widget/student_animation.dart';
import 'package:my_app/feature/quiz/presentation/riverpod/quiz_questions_provider.dart';
import 'package:my_app/l10n/l10n.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    ref.watch(quizQuestionsProvider);
    final themeSwitcherState = ref.read(themeProvider);
    final themeSwitcherNotifier = ref.read(themeProvider.notifier);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            l10n.appBarTitle,
            style: context.texts.headline6.copyWith(
              color: context.appTheme.onPrimary,
            ),
          ),
          actions: [
            Tooltip(
              message: 'Switch Theme',
              child: Row(
                children: [
                  Switch(
                    value: themeSwitcherState.isDark,
                    onChanged: (_) {
                      themeSwitcherNotifier.toggleTheme();
                    },
                  ),
                  Text(
                    themeSwitcherState.isDark ? 'Dark' : 'Light',
                    style: context.texts.bodyText1.copyWith(
                      color: context.appTheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Hero(tag: 'student', child: StudentAnimation()),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton.filled(
                      label: l10n.quizButton,
                      onPressed: () {
                        context.pushNamed(Routes.quiz);
                      },
                      width: 0.4.sw,
                    ),
                    AppButton.filled(
                      label: l10n.leaderboardButton,
                      onPressed: () {
                        context.pushNamed(Routes.leaderBoard);
                      },
                      width: 0.4.sw,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
