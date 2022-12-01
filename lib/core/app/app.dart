import 'package:sports_meet/core/services/authentication_service.dart';
import 'package:sports_meet/core/services/stream_service.dart';
import 'package:sports_meet/features/authentication_features/forgot_password_view.dart';
import 'package:sports_meet/features/authentication_features/login_view.dart';
import 'package:sports_meet/features/authentication_features/sign_up_view.dart';
import 'package:sports_meet/features/authentication_features/verify_phone.dart';
import 'package:sports_meet/features/landing_features/landing_view.dart';
import 'package:sports_meet/features/settings_features/edit_profile_view.dart';
import 'package:sports_meet/features/settings_features/update_password_view.dart';
import 'package:sports_meet/features/splash_features/splash_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

///I'm using stacked architecture for state management, dependency injection, etc.
///For code generation anytime u add anything below: flutter pub run build_runner build --delete-conflicting-outputs

@StackedApp(
  routes: [
    AdaptiveRoute(page: SplashView, initial: true),
    AdaptiveRoute(page: VerifyPhoneView),
    AdaptiveRoute(page: SignUpView),
    AdaptiveRoute(page: LoginView),
    AdaptiveRoute(page: ForgotPasswordView),
    AdaptiveRoute(page: LandingView),
    AdaptiveRoute(page: EditProfileView),
    AdaptiveRoute(page: UpdatePasswordView),
  ],
  logger: StackedLogger(),
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: ServiceEventStream<ServiceEvent>),
  ],
)

class AppSetup {}