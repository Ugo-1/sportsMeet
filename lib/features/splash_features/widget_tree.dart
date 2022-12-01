import 'package:flutter/material.dart';
import 'package:sports_meet/core/app/app.locator.dart';
import 'package:sports_meet/core/services/authentication_service.dart';
import 'package:sports_meet/features/authentication_features/sign_up_view.dart';
import 'package:sports_meet/features/landing_features/landing_view.dart';

class WidgetTree extends StatelessWidget {

  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  WidgetTree({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    if (_authenticationService.currentUser == null){
      return const SignUpView();
    }
    return const LandingView();
  }
}


