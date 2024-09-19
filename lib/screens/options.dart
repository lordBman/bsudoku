import 'package:bsudoku/components/buttons/custom_text_button.dart';
import 'package:bsudoku/components/option_group_widget.dart';
import 'package:bsudoku/components/option_widget.dart';
import 'package:bsudoku/mixins/app_review_mixin.dart';
import 'package:bsudoku/mixins/share_mixin.dart';
import 'package:bsudoku/providers/options.dart';
import 'package:bsudoku/services/localization_manager.dart';
import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/game_routes.dart';
import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsScreen extends StatefulWidget {
    const OptionsScreen({super.key});

    @override
    State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> with ShareMixin, AppReviewMixin {
    @override
    void initState() {
        super.initState();
        onStateChange = () => setState(() {});
    }

    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider<OptionsScreenProvider>(create: (context) => OptionsScreenProvider(),
            child: Consumer<OptionsScreenProvider>(builder: ((context, provider, _) {
                return Scaffold(backgroundColor: GameColors.optionsBackground,
                    appBar: AppBar(elevation: 0.5, leadingWidth: 0, centerTitle: true, backgroundColor: GameColors.appBarBackground,
                        title: Text("options".tr(), style: GameTextStyles.optionsScreenAppBarTitle.copyWith(fontSize: GameSizes.getWidth(0.045))),
                        leading: const SizedBox.shrink(),
                        actions: [CustomTextButton(text: "done".tr())],
                    ),
                    body: SingleChildScrollView(padding: GameSizes.getSymmetricPadding(0.04, 0.02),
                        child: Column(children: [
                            OptionGroup(options: [
                                OptionWidget(title: LocalizationManager.currentLanguageName, iconColor: Colors.pink, iconData: Icons.language,
                                    onTap: () => LocalizationManager.changeLocale(context, LocalizationManager.currentLocale.languageCode == 'en' ? LocalizationManager.supportedLocales[1] : LocalizationManager.supportedLocales[0]),
                                ),
                            ]),
                            OptionGroup(options: [
                                OptionWidget(title: "howToPlay".tr(), iconColor: Colors.green, iconData: Icons.school,
                                    onTap: () => GameRoutes.goTo(GameRoutes.howToPlayScreen, enableBack: true)),
                                OptionWidget(title: "rules".tr(), iconColor: Colors.lightBlue, iconData: Icons.menu_book_rounded,
                                    onTap: () => GameRoutes.goTo(GameRoutes.rulesScreen, enableBack: true)),
                            ]),
                            OptionGroup(options: [
                                OptionWidget(title: "aboutGame".tr(), iconColor: Colors.blue.shade700, iconData: Icons.info,
                                    onTap: () => GameRoutes.goTo(GameRoutes.aboutScreen, enableBack: true)),
                                OptionWidget(title: "rateUs".tr(), iconColor: Colors.yellow, iconData: Icons.star, loading: reviewLoading,
                                    onTap: () => openStoreListing()),
                                OptionWidget( title: "share".tr(), iconColor: Colors.orange, iconData: Icons.share, loading: shareLoading,
                                    onTap: () => shareApp("shareText".tr(args: [
                                        'https://play.google.com/store/apps/details?id=com.recepsenoglu.sudoku'
                                    ]))),
                            ]),
                        ]),
                    ),
                );
            })),
        );
    }
}
