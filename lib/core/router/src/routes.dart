part of '../router.dart';

extension Convert on String {
  String get p => '/$this';
}

class Routes {
  Routes._();

  static const splash = '/';
  static const home = 'home';
  static const quiz = 'quiz';
  static const quizFinish = 'quiz_finish';
  static const leaderBoard = 'leaderboard';
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Routes.splash.p,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: Routes.splash,
        path: Routes.splash,
        pageBuilder: (context, state) => PageTransitionWrapper(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        name: Routes.home,
        path: Routes.home.p,
        pageBuilder: (context, state) => PageTransitionWrapper(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        name: Routes.quiz,
        path: Routes.quiz.p,
        pageBuilder: (context, state) => PageTransitionWrapper(
          key: state.pageKey,
          child: const QuizPage(),
        ),
      ),
      GoRoute(
        name: Routes.quizFinish,
        path: Routes.quizFinish.p,
        pageBuilder: (context, state) => PageTransitionWrapper(
          key: state.pageKey,
          child: const QuizFinishPage(),
        ),
      ),
      GoRoute(
        name: Routes.leaderBoard,
        path: Routes.leaderBoard.p,
        pageBuilder: (context, state) => PageTransitionWrapper(
          key: state.pageKey,
          child: const LeaderBoardPage(),
        ),
      ),
    ],
  );

  return router;
});
