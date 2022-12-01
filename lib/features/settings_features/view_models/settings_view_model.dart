import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_meet/core/app/app.locator.dart';
import 'package:sports_meet/core/app/app.router.dart';
import 'package:sports_meet/core/models/user.dart';
import 'package:sports_meet/core/services/authentication_service.dart';
import 'package:sports_meet/core/services/stream_service.dart';
import 'package:sports_meet/core/models/settings_list_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {

  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ServiceEventStream _serviceStream = locator<ServiceEventStream>();
  UserModel? userModel;
  User? user;
  late StreamSubscription<ServiceEvent>? subscription;

  SettingsViewModel([StreamSubscription<ServiceEvent>? subService]){
    subscription = subService ?? _serviceStream.listen(serviceEventListener);
  }

  void serviceEventListener(ServiceEvent event){
    if(event.type == ServiceEventType.updateProfile){
      fetchProfile();
    }
  }

  List<SettingsListModel> get firstSettingsList => [
    SettingsListModel(name: 'Update Password', onTap: updatePassword),
    SettingsListModel(name: 'Notifications',),
    SettingsListModel(name: 'Language',),
  ];

  List<SettingsListModel> get secondSettingsList => [
    SettingsListModel(name: 'Contact us',),
    SettingsListModel(name: 'Terms and Privacy',),
  ];

  void fetchProfile(){
    userModel = _authenticationService.currentUser;
    user = _auth.currentUser;
    notifyListeners();
  }

  void moveToEditProfileView(){
    _navigationService.navigateToEditProfileView();
  }

  void updatePassword(){
    _navigationService.navigateToUpdatePasswordView();
  }

  void logOut(){
    _authenticationService.logOut();
    _navigationService.pushNamedAndRemoveUntil(Routes.signUpView);
  }

}