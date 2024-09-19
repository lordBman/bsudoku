import 'package:bsudoku/models/game_model.dart';
import 'package:bsudoku/screens/main.dart';
import 'package:bsudoku/screens/statistics.dart';
import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NavigationBarScreen extends StatefulWidget {
    final int? pageIndex;
    final GameModel? savedGame;

    const NavigationBarScreen({super.key, this.pageIndex, this.savedGame });

    @override
    State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
    int _selectedIndex = -1;

    List<BottomNavigationBarItem> get navigationBarItems => [
        BottomNavigationBarItem(label: "home".tr(), icon: Icon(Icons.home, size: GameSizes.getWidth(0.08))),
        BottomNavigationBarItem(label: "statistics".tr(), icon: Icon(Icons.bar_chart, size: GameSizes.getWidth(0.08))),
    ];

    void onTappedItem(int index) {
        setState(() => _selectedIndex = index);
    }

    @override
    Widget build(BuildContext context) {
        _selectedIndex = _selectedIndex == -1 ? (widget.pageIndex ?? 0) : _selectedIndex;

        List<Widget> screens = [ MainScreen(savedGame: widget.savedGame), const StatisticsScreen() ];

        return Scaffold( backgroundColor: GameColors.background,
            bottomNavigationBar: BottomNavigationBar(
                elevation: 10, onTap: onTappedItem, items: navigationBarItems, currentIndex: _selectedIndex,
                backgroundColor: Colors.white, type: BottomNavigationBarType.fixed, selectedItemColor: GameColors.navigationBarItemActive,
                unselectedItemColor: GameColors.navigationBarItemPassive, selectedLabelStyle: GameTextStyles.navigationBarItemLabel.copyWith(fontSize: GameSizes.getWidth(0.032)),
                unselectedLabelStyle: GameTextStyles.navigationBarItemLabel.copyWith(fontSize: GameSizes.getWidth(0.032)),
            ),
            body: screens[_selectedIndex]);
    }
}
