import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/core/extensions/extensions.dart';
import 'package:my_app/core/ui/assets/app_assets.dart';
import 'package:my_app/feature/quiz/domain/entities/quiz_entities.dart';
import 'package:my_app/feature/quiz/presentation/riverpod/leader_board_provider.dart';

class LeaderBoardTopWidget extends StatelessWidget {
  const LeaderBoardTopWidget({
    this.placement = 1,
    this.score,
    super.key,
  });
  final Score? score;
  final int placement;

  @override
  Widget build(BuildContext context) {
    final first = placement == 1;
    return Container(
      width: first ? 0.33.sw : 0.28.sw,
      height: first ? 0.33.sw : 0.28.sw,
      decoration: context.boxDecor.basic().copyWith(
            color:
                first ? context.appTheme.secondary : context.appTheme.warning,
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            score?.name ?? 'N/A',
            style: context.texts.headline6.copyWith(
              color: context.appTheme.onPrimary,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            "${score?.score ?? 'N/A'}",
            style: context.texts.headline6.copyWith(
              color: context.appTheme.onPrimary,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Transform.translate(
            offset: Offset(0, first ? 40 : 20),
            child: SizedBox(
              height: 0.12.sw,
              width: 0.12.sw,
              child: SvgPicture.asset(
                AppAssets.svgs.medal(placement),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopThreeSection extends ConsumerWidget {
  const TopThreeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderBoardState = ref.watch(leaderBoardProvider);
    final topThree = leaderBoardState.topThree;

    return topThree.isEmpty
        ? Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: context.boxDecor.basic(),
            child: Text(
              'Leader Board is Empty',
              style: context.texts.headline6.copyWith(
                color: context.appTheme.onSurface,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LeaderBoardTopWidget(
                score: topThree.length >= 2 ? topThree[1] : null,
                placement: 2,
              ),
              LeaderBoardTopWidget(
                score: topThree.isNotEmpty ? topThree[0] : null,
              ),
              LeaderBoardTopWidget(
                score: topThree.length >= 3 ? topThree[2] : null,
                placement: 3,
              ),
            ],
          );
  }
}
