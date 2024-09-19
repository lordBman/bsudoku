import 'package:bsudoku/models/game_model.dart';
import 'package:bsudoku/screens/game.dart';
import 'package:bsudoku/screens/navigation_bar.dart';
import 'package:bsudoku/screens/options.dart';
import 'package:bsudoku/screens/options/about.dart';
import 'package:bsudoku/screens/options/how_to_play.dart';
import 'package:bsudoku/screens/options/privacy_policy.dart';
import 'package:bsudoku/screens/options/rules.dart';
import 'package:bsudoku/screens/options/settings.dart';
import 'package:bsudoku/screens/options/terms_of_use.dart';
import 'package:bsudoku/screens/statistics.dart';
import 'package:bsudoku/screens/win.dart';
import 'package:flutter/material.dart';

class GameRoutes {
    static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    static const String navigationBar = '/navigation_bar';
    static const String statisticsScreen = '/statistics_screen';
    static const String gameScreen = '/game_screen';
    static const String winScreen = '/win_screen';
    static const String optionsScreen = '/options_screen';
    static const String settingsScreen = '/settings_screen';
    static const String aboutScreen = '/about_screen';
    static const String termsOfUseScreen = '/terms_of_use_screen';
    static const String privacyPolicyScreen = '/privacy_policy_screen';
    static const String rulesScreen = '/rules_screen';
    static const String howToPlayScreen = '/how_to_play_screen';

    static Route<dynamic>? generateRoute(RouteSettings settings) {
        final args = settings.arguments;

        switch (settings.name) {
            case navigationBar:
                return MaterialPageRoute(builder: (_) => args != null ? NavigationBarScreen(pageIndex: (args as List)[0] as int, savedGame: args.length > 1 ? args[1] as GameModel? : null) : const NavigationBarScreen());
            case gameScreen:
                return MaterialPageRoute(builder: (_) => GameScreen(gameModel: args as GameModel));
            case statisticsScreen:
                return MaterialPageRoute(builder: (_) => const StatisticsScreen());
            case optionsScreen:
                return MaterialPageRoute(builder: (_) => const OptionsScreen());
            case settingsScreen:
                return MaterialPageRoute(builder: (_) => const SettingsScreen());
            case winScreen:
                return MaterialPageRoute(builder: (_) => WinScreen(gameModel: args as GameModel));
            case aboutScreen:
                return MaterialPageRoute(builder: (_) => const AboutGameScreen());
            case termsOfUseScreen:
                return MaterialPageRoute(builder: (_) => const TermsOfUseScreen());
            case privacyPolicyScreen:
                return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());
            case rulesScreen:
                return MaterialPageRoute(builder: (_) => const RulesScreen());
            case howToPlayScreen:
                return MaterialPageRoute(builder: (_) => const HowToPlayScreen());
            default:
                return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }

  static Future<void> goTo(
      String route, {
        args,
        bool enableBack = false,
        Function()? callBackAfter,
      }) async {
    debugPrint('GO TO $route');
    await Navigator.of(GameRoutes.navigatorKey.currentContext!)
        .pushNamedAndRemoveUntil(
      route,
      arguments: args,
          (route) => enableBack,
    );
    if (callBackAfter != null) {
      callBackAfter();
    }
  }

  static void goToPageThenCallFunction(Function() function) {}

  static void back({int backTimes = 1, bool returnDialog = false}) {
    debugPrint('GO BACK <- ${returnDialog ? 'return $returnDialog' : ''}');
    for (var i = 0; i < backTimes; i++) {
      if (Navigator.canPop(GameRoutes.navigatorKey.currentContext!)) {
        Navigator.pop(GameRoutes.navigatorKey.currentContext!, returnDialog);
      }
    }
  }
}
