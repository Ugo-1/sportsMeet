import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sports_meet/core/app/app.locator.dart';
import 'package:sports_meet/core/app/app.router.dart';
import 'package:sports_meet/core/models/interest.dart';
import 'package:sports_meet/core/models/user.dart';
import 'package:sports_meet/core/services/authentication_service.dart';
import 'package:sports_meet/core/services/firestore_service.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/string_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FireStoreService _fireStoreService = FireStoreService();

  bool passwordHide = true;
  bool confirmPasswordHide = true;

  final interestList = <Interest>[
    Interest(
      name: 'Football',
      iconData: Icons.sports_soccer_rounded,
      color: Palette.mainBlack,
    ),
    Interest(
      name: 'Rugby',
      iconData: Icons.sports_rugby_rounded,
      color: Palette.rugby,
    ),
    Interest(
      name: 'Basketball',
      iconData: Icons.sports_basketball_rounded,
      color: Palette.basketball,
    ),
    Interest(
      name: 'Tennis',
      iconData: Icons.sports_tennis_rounded,
      color: Palette.mainBlack,
    ),
    Interest(
      name: 'Skiing',
      iconData: Icons.downhill_skiing_rounded,
      color: Palette.ski,
    ),
    Interest(
      name: 'Hockey',
      iconData: Icons.sports_hockey_rounded,
      color: Palette.mainBlack,
    ),
    Interest(
      name: 'Volleyball',
      iconData: Icons.sports_volleyball_rounded,
      color: Palette.volleyball,
    ),
    Interest(
      name: 'Golf',
      iconData: Icons.sports_golf_rounded,
      color: Palette.golf,
    ),
  ];

  void signUp({required String email, required String password, required UserModel userModel,}) async {
    setBusy(true);
    try {
     UserCredential userCredential = await _authenticationService.registerUser(email: email, password: password,);
     final user = userCredential.user;
     if (user != null){
       await _fireStoreService.createUser(user: userModel.update(id: user.uid));
       _navigationService.navigateToVerifyPhoneView(number: userModel.number, routeName: StringUtils.signUpView);
     } else {
       throw Exception();
     }
    } on FirebaseAuthException catch (e){
      _dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    } on TimeoutException {
      _dialogService.showDialog(
        title: 'Error',
        description: 'Timeout Error Occurred',
      );
    } on SocketException {
      _dialogService.showDialog(
        title: 'Error',
        description: 'Please check your internet',
      );
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: 'Something occurred. Please try again later.',
      );
    } finally {
      setBusy(false);
    }
  }

  void moveToLoginView(){
    _navigationService.replaceWith(Routes.loginView);
  }

  void togglePasswordVisibility(){
    passwordHide = !passwordHide;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility(){
    confirmPasswordHide = !confirmPasswordHide;
    notifyListeners();
  }
}
