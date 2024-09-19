import 'package:bsudoku/components/app_bar_action_button.dart';
import 'package:bsudoku/components/buttons/rounded_button.dart';
import 'package:bsudoku/models/game_model.dart';
import 'package:bsudoku/providers/main.dart';
import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/game_routes.dart';
import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
    final GameModel? savedGame;

    const MainScreen({this.savedGame, super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold( backgroundColor: GameColors.mainScreenBg,
            appBar: AppBar( elevation: 0, toolbarHeight: GameSizes.getWidth(0.12), backgroundColor: GameColors.mainScreenBg,
                systemOverlayStyle: SystemUiOverlayStyle.dark, leading: const SizedBox.shrink(),
                actions: [
                    AppBarActionButton( onPressed: () => GameRoutes.goTo(GameRoutes.optionsScreen, enableBack: true), icon: Icons.settings_outlined,
                        iconSize: GameSizes.getWidth(0.08)),
                    SizedBox(width: GameSizes.getWidth(0.02)),
                ]),
            body: ChangeNotifierProvider<MainScreenProvider>(create: (context) => MainScreenProvider(savedGame: savedGame),
                child: Consumer<MainScreenProvider>(builder: (context, provider, _) {
                    return Padding(padding: GameSizes.getSymmetricPadding(0.05, 0.02), child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        // const ChallengeAndEvents(),
                        const AppLogo(),
                        GameTitle(title: "appName".tr(args: [":\n"])),
                        Container(height: GameSizes.getHeight(0.25), padding: GameSizes.getHorizontalPadding(0.05), child: Column( children: [
                            Visibility( visible: provider.isThereASavedGame, child: Padding(padding: EdgeInsets.only(bottom: GameSizes.getHeight(0.02)),
                                child: RoundedButton( buttonText: "continueGame".tr(), subText: provider.continueGameButtonText, subIcon: Icons.watch_later_outlined,
                                    onPressed: provider.continueGame, textSize: GameSizes.getHeight(0.02)),
                            )),
                            RoundedButton( buttonText: "newGame".tr(), whiteButton: provider.isThereASavedGame, elevation: provider.isThereASavedGame ? 5 : 0,
                                onPressed: provider.newGame, textSize: GameSizes.getHeight(0.022)),
                        ])),
                    ]));
                })
            ),
        );
    }
}

class GameTitle extends StatelessWidget {
    final String title;

    const GameTitle({super.key, required this.title});

    @override
    Widget build(BuildContext context) {
        return Padding(padding: GameSizes.getHorizontalPadding(0.05),
            child: FittedBox(child: Center( child: Text( title, textAlign: TextAlign.center, style: GameTextStyles.mainScreenTitle.copyWith(fontSize: GameSizes.getWidth(0.08))))),
        );
    }
}

class AppLogo extends StatelessWidget {
    const AppLogo({super.key});

    @override
    Widget build(BuildContext context) {
        return Container( decoration: BoxDecoration(color: GameColors.mainScreenBg, borderRadius: BorderRadius.circular(32),
            image: const DecorationImage(image: AssetImage('assets/images/play_store_512.png'), fit: BoxFit.contain)),
            child: SizedBox(width: GameSizes.getWidth(0.42), height: GameSizes.getWidth(0.42)),
        );
    }
}

class ChallengeAndEvents extends StatelessWidget {
    const ChallengeAndEvents({super.key});

    @override
    Widget build(BuildContext context) {
        return Container(height: GameSizes.getHeight(0.25), width: double.infinity, padding: GameSizes.getPadding(0.02), decoration: BoxDecoration(border: Border.all()),
            child: Center(child: Text('This app is being developed by \n @recepsenoglu', textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: GameSizes.getHeight(0.025)))),
        );
    }
}
