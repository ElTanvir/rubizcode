part of '../extensions.dart';

extension GoRouterExtension on BuildContext {
  void pushNamedAndRemoveUntil(String routeName) {
    while (canPop()) {
      pop();
    }
    pushReplacementNamed(routeName);
  }
}
