import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_meet/core/app/app.locator.dart';
import 'package:sports_meet/core/app/app.router.dart';
import 'package:sports_meet/core/models/user.dart';
import 'package:sports_meet/core/services/authentication_service.dart';
import 'package:sports_meet/core/utils/string_utils.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VerifyPhoneViewModel extends BaseViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DialogService _dialogService = locator<DialogService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  User? get user => _auth.currentUser;
  String? get uid => user?.uid;

  bool disableResendToken = true;
  String? verificationID;

  Future<void> verifyNumber(String phoneNumber, String routeName) async {
    disableResendToken = true;
    notifyListeners();
    await _auth.verifyPhoneNumber(
      timeout: const Duration(
        seconds: 50,
      ),
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential authCredential) async {
        if (routeName == StringUtils.signUpView) {
          await user?.linkWithCredential(authCredential);
          _authenticationService.updateUser(
            uid: uid!,
            json: {
              UserField.verified: true,
            },
          );
        } else if (routeName == StringUtils.loginView) {
          await _auth.signInWithCredential(authCredential);
          await _authenticationService.isUserLoggedIn();
        }
        _navigationService.pushNamedAndRemoveUntil(Routes.landingView);
      },
      verificationFailed: ((error) {
        _dialogService.showDialog(
          title: 'Error',
          description: error.message,
        );
        disableResendToken = false;
        notifyListeners();
      }),
      codeSent: (String verificationId, [int? forceResendingToken]) {
        verificationID = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        disableResendToken = false;
        notifyListeners();
      },
    );
  }

  void moveToLandingView(String smsCode, String routeName) async {
    setBusy(true);
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID!, smsCode: smsCode);
      if (routeName == StringUtils.signUpView) {
        await user?.linkWithCredential(credential);
        _authenticationService.updateUser(
          uid: uid!,
          json: {
            UserField.verified: true,
          },
        );
      } else if (routeName == StringUtils.loginView) {
        _auth.signInWithCredential(credential);
        await _authenticationService.isUserLoggedIn();
      }
      _navigationService.pushNamedAndRemoveUntil(Routes.landingView);
    } on FirebaseAuthException catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: 'Something occurred. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }
}
