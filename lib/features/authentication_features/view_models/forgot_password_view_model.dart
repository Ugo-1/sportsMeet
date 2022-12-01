import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_meet/core/app/app.locator.dart';
import 'package:sports_meet/core/app/app.router.dart';
import 'package:sports_meet/core/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ForgotPasswordViewModel extends BaseViewModel {

  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void resetPassword({required String email}) async {
    setBusy(true);
    try {
      await _authenticationService.forgotPassword(email: email);
      _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
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
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: 'Something occurred. Please try again later.',
      );
    } finally {
      setBusy(false);
    }
  }

}