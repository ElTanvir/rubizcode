import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/extensions/extensions.dart';
import 'package:my_app/core/router/router.dart';
import 'package:my_app/core/ui/widgets/app_button.dart';
import 'package:my_app/feature/quiz/presentation/riverpod/leader_board_provider.dart';
import 'package:my_app/feature/quiz/presentation/widgets/leader_board_top_three_widget.dart';

class LeaderBoardPage extends ConsumerStatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LeaderBoardPageState();
}

class _LeaderBoardPageState extends ConsumerState<LeaderBoardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final leaderBoardState = ref.watch(leaderBoardProvider);
    final sortedScores = leaderBoardState.sortedScores;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Leader Board',
            style: context.texts.headline6.copyWith(
              color: context.appTheme.onPrimary,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              const TopThreeSection(),
              50.ph,
              Expanded(
                child: sortedScores.isEmpty
                    ? Center(
                        child: Text(
                          'Not Enough Participant',
                          style: context.texts.headline6.copyWith(
                            color: context.appTheme.onSurface,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: sortedScores.length,
                        itemBuilder: (context, index) {
                          final player = sortedScores[index];
                          return Padding(
                            padding:
                                EdgeInsets.only(top: index == 0 ? 0 : 16.h),
                            child: Container(
                              decoration: context.boxDecor.basic(),
                              width: 1.sw,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    player.name,
                                    style: context.texts.subtitle1,
                                  ),
                                  10.ph,
                                  Text(
                                    'Score: ${player.score}',
                                    style: context.texts.subtitle2,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              20.ph,
              AppButton.filled(
                label: 'Play',
                onPressed: () {
                  context.pushNamed(Routes.quiz);
                },
              ),
              20.ph,
            ],
          ),
        ),
      ),
    );
  }
}
