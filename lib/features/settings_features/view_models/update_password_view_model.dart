import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_meet/core/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UpdatePasswordViewModel extends BaseViewModel {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final Duration timeOutLimit = const Duration(seconds: 20);

  bool oldPasswordHide = true;
  bool newPasswordHide = true;
  bool confirmPasswordHide = true;

  User? user;


  void fetchPassword(){
    user = _auth.currentUser!;
    notifyListeners();
  }

  void toggleOldPasswordVisibility(){
    oldPasswordHide = !oldPasswordHide;
    notifyListeners();
  }

  void toggleNewPasswordVisibility(){
    newPasswordHide = !newPasswordHide;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility(){
    confirmPasswordHide = !confirmPasswordHide;
    notifyListeners();
  }

  void updatePassword({required String newPassword, required String confirmPassword}) async {
    setBusy(true);
    try{
      await user?.updatePassword(newPassword).timeout(timeOutLimit);
      _navigationService.back();
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

  void cancel(){
    _navigationService.back();
  }

}