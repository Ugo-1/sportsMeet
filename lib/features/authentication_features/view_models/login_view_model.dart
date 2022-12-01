import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_meet/core/app/app.locator.dart';
import 'package:sports_meet/core/app/app.router.dart';
import 'package:sports_meet/core/services/authentication_service.dart';
import 'package:sports_meet/core/utils/string_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {

  bool emailSign = true;
  bool passwordHide = true;

  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();

  void togglePage(){
    emailSign = !emailSign;
    notifyListeners();
  }

  void togglePasswordVisibility(){
    passwordHide = !passwordHide;
    notifyListeners();
  }

  void moveToForgotPassword(){
    _navigationService.navigateTo(Routes.forgotPasswordView);
  }

  void signInEmail({required String email, required String password}) async {
    setBusy(true);
    try {
      UserCredential userCredential = await _authenticationService.loginUserEmail(email: email, password: password);
      User? user = userCredential.user;

      ///Check if user is present
      if (user != null){
        await _authenticationService.isUserLoggedIn();
        _navigationService.pushNamedAndRemoveUntil(Routes.landingView);
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

  void signInPhoneNumber({required String phoneNumber}) {
    _navigationService.navigateToVerifyPhoneView(number: phoneNumber, routeName: StringUtils.loginView);
  }

  void moveToSignUpView(){
    _navigationService.replaceWith(Routes.signUpView);
  }

}
