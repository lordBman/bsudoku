import 'package:bsudoku/components/buttons/rounded_button.dart';
import 'package:bsudoku/components/star_badge_widget.dart';
import 'package:bsudoku/providers/daily_challenges.dart';
import 'package:bsudoku/utils/constants.dart';
import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailyChallengesScreen extends StatelessWidget {
    const DailyChallengesScreen({super.key});

    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider<DailyChallengesScreenProvider>(create: (context) => DailyChallengesScreenProvider(), child: Consumer<DailyChallengesScreenProvider>(builder: (context, provider, _) {
            return Scaffold(backgroundColor: GameColors.dailyChallengesScreenBg, body: Stack(children: [
                Column(children: [
                    const TopBlueBox(),
                    CalendarWidget(provider: provider),
                    PlayButton(onPressed: provider.play),
                    const SizedBox(height: 36),
                ]),
                Image.asset('assets/images/inProgress.png'),
            ]));
        }));
    }
}

class PlayButton extends StatelessWidget {
    final Function() onPressed;

    const PlayButton({required this.onPressed, super.key });

    @override
    Widget build(BuildContext context) {
        return Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: RoundedButton(buttonText: "GameStrings.play", onPressed: onPressed));
    }
}

class CalendarWidget extends StatelessWidget {
    final DailyChallengesScreenProvider provider;

    const CalendarWidget({ required this.provider, super.key });

    @override
    Widget build(BuildContext context) {
        final DateTime now = DateTime.now();
        final int firstDayOfMonth = now.copyWith(day: 1).weekday;

        return Expanded(child: Padding(padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20), child: Column(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${months[now.month - 1]} ${now.year}', style: GameTextStyles.calendarDateTitle),
                const Spacer(),
                const StarBadgeWidget(),
                const SizedBox(width: 8),
                Text('1/30', style: GameTextStyles.calendarDateTitle),
            ]),
            const SizedBox(height: 18),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 18), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(days.length, (index) {
                    return SizedBox(width: 10, child: Text(days[index], textAlign: TextAlign.center, style: GameTextStyles.calendarDays));
                }),
            )),
            const SizedBox(height: 18),
            Expanded(child: GridView.count(crossAxisCount: 7, padding: const EdgeInsets.symmetric(horizontal: 6),
                crossAxisSpacing: 20, mainAxisSpacing: 10, shrinkWrap: true,
                children: List.generate(35, (index) {
                    final int day = index - firstDayOfMonth + 1;
                    final bool isFuture = day > now.day;
                    final bool isCurrentMonth = index >= firstDayOfMonth;
                    final bool isCompleted = isCurrentMonth && day == 3;
                    final bool isStarted = isCurrentMonth && day == 5;
                    final bool isSelected = isCurrentMonth && provider.selectedDay == day;

                    if (isCompleted) {
                        return const StarBadgeWidget();
                    }

                    return InkWell(highlightColor: Colors.transparent, splashColor: Colors.transparent, onTap: () => provider.selectDay(day),
                        child: Stack(alignment: Alignment.center, children: [
                            Container(width: 100, decoration: getDecoration(isSelected),
                                child: Center(child: Text(isCurrentMonth ? '$day' : '', style: isFuture ? GameTextStyles.calendarFutureDate : isSelected ? GameTextStyles.calendarDateSelected : GameTextStyles.calendarDate)),
                            ), getProgressIndicator(isStarted, isSelected),
                        ]),
                    );
                }),
            )),
        ])));
    }

    BoxDecoration? getDecoration(bool isSelected) {
        return isSelected ? BoxDecoration(shape: BoxShape.circle, color: GameColors.roundedButton) : null;
    }

    Widget getProgressIndicator(bool isStarted, bool isSelected) {
        if (isStarted) {
            return Padding(padding: EdgeInsets.all(isSelected ? 4 : 2),
                child: CircularProgressIndicator(value: 0.4, strokeWidth: 3, color: isSelected ? Colors.white : GameColors.roundedButton, backgroundColor: isSelected ? GameColors.progressBgSelected : GameColors.lightGreyColor),
            );
        }
        return const SizedBox();
    }
}

class TopBlueBox extends StatelessWidget {
    const TopBlueBox({ super.key });

    @override
    Widget build(BuildContext context) {
        return Container(height: 330, width: double.infinity, padding: EdgeInsets.only(top: GameSizes.topPadding + 20),
            decoration: BoxDecoration(color: Colors.blue.shade700), child: Column(children: [
                const SizedBox(height: 18),
                Text("GameStrings.dailyChallenges", style: GameTextStyles.dailyChallengesTitle),
            ]),
        );
    }
}