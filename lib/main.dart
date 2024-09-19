import 'package:bsudoku/services/localization_manager.dart';
import 'package:bsudoku/utils/game_routes.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    runApp(
        EasyLocalization(
            path: LocalizationManager.path, fallbackLocale: LocalizationManager.fallbackLocale,
            supportedLocales: LocalizationManager.supportedLocales,
            child: const Game(),
        ),
    );
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    GameSizes.init(context);

    return MaterialApp(
        title: 'Sudoku',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        navigatorKey: GameRoutes.navigatorKey,
        onGenerateRoute: GameRoutes.generateRoute,
        initialRoute: GameRoutes.navigationBar,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
    );
  }
}
