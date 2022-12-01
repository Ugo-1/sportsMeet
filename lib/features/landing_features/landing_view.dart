import 'package:flutter/material.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/size_manager.dart';
import 'package:sports_meet/features/buddies_features/buddies_view.dart';
import 'package:sports_meet/features/discover_features/discover_view.dart';
import 'package:sports_meet/features/landing_features/view_models/landing_view_model.dart';
import 'package:sports_meet/features/profile_features/profile_view.dart';
import 'package:sports_meet/features/settings_features/settings_view.dart';
import 'package:stacked/stacked.dart';

class LandingView extends StatefulWidget {
  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return ViewModelBuilder<LandingViewModel>.reactive(
      viewModelBuilder: () => LandingViewModel(),
      builder: (_, model, __) => Scaffold(
        body: getView(model.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Palette.primaryRed,
          selectedFontSize: SizeMg.text(12),
          unselectedFontSize: SizeMg.text(12),
          unselectedItemColor: Palette.inactiveTextField,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 34,
              ),
              activeIcon: Icon(
                Icons.person,
                color: Palette.primaryRed,
                size: 34,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
                size: 34,
              ),
              activeIcon: Icon(
                Icons.group,
                color: Palette.primaryRed,
                size: 34,
              ),
              label: 'Buddies',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 34,
              ),
              activeIcon: Icon(
                Icons.search,
                color: Palette.primaryRed,
                size: 34,
              ),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 34,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Palette.primaryRed,
                size: 34,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget getView(int index) {
    switch (index) {
      case 0:
        return ProfileView();
      case 1:
        return const BuddiesView();
      case 2:
        return const DiscoverView();
      case 3:
        return const SettingsView();
      default:
        return ProfileView();
    }
  }
}
