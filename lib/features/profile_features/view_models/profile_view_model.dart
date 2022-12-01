import 'package:sports_meet/core/app/app.locator.dart';
import 'package:sports_meet/core/models/user.dart';
import 'package:sports_meet/core/services/authentication_service.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  UserModel? userModel;

  void initialize(){
    userModel = _authenticationService.currentUser;
    notifyListeners();
  }

}
