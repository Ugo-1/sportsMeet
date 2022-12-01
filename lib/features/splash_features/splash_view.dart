import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sports_meet/core/app/app.locator.dart';
import 'package:sports_meet/core/services/authentication_service.dart';
import 'package:sports_meet/core/utils/image_utils.dart';
import 'package:sports_meet/features/splash_features/widget_tree.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  @override
  void initState() {
    super.initState();
    checkLoggedIn();
  }

  void checkLoggedIn() async {
    ///Check if user is logged in
    await _authenticationService.isUserLoggedIn();
    Timer(
      const Duration(milliseconds: 500),
      () {
        _navigationService.replaceWithTransition(WidgetTree(),
            transitionStyle: Transition.leftToRightWithFade);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(ImageUtils.splashIcon),
        ),
      ),
    );
  }
}
