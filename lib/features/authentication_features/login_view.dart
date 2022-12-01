import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sports_meet/core/shareable_widgets/primary_button.dart';
import 'package:sports_meet/core/utils/color_palette.dart';
import 'package:sports_meet/core/utils/constants.dart';
import 'package:sports_meet/core/utils/image_utils.dart';
import 'package:sports_meet/core/utils/size_manager.dart';
import 'package:sports_meet/core/utils/validator_utils.dart';
import 'package:sports_meet/features/authentication_features/view_models/login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formEmailKey = GlobalKey<FormState>();
  final FocusManager focusManager = FocusManager.instance;

  late TextEditingController email;
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController number;
  late TextEditingController confirmPassword;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    number = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeMg.init(context);
    return Scaffold(
      body: ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (_, model, __) => ModalProgressHUD(
          inAsyncCall: model.isBusy,
          progressIndicator: const CircularProgressIndicator(
            color: Palette.primaryRed,
          ),
          child: GestureDetector(
            onTap: focusManager.primaryFocus?.unfocus,
            child: SafeArea(
              child: Builder(
                builder: (context) {
                  ///Email Sign in
                  if (model.emailSign){
                    return Form(
                      key: _formEmailKey,
                      child: ListView(
                        padding: EdgeInsets.only(
                          left: SizeMg.width(30.0),
                          right: SizeMg.width(30.0),
                          top: SizeMg.height(30.0),
                        ),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Image.asset(
                            ImageUtils.splashIcon,
                            height: SizeMg.height(100),
                          ),
                          SizedBox(
                            height: SizeMg.height(20),
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: SizeMg.text(30.0),
                            ),
                          ),

                          ///EmailField
                          SizedBox(
                            height: SizeMg.height(50.0),
                          ),
                          TextFormField(
                            controller: email,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontSize: SizeMg.text(16),
                              fontWeight: FontWeight.w400,
                              color: Palette.mainBlack,
                              letterSpacing: 0.3,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Palette.inactiveTextField,
                              ),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (ValidatorUtils.isEmpty(value)) {
                                return 'Email cannot be left blank';
                              }
                              if (ValidatorUtils.isNotEmail(value)) {
                                return 'Email must contain @';
                              }
                              return null;
                            },
                          ),

                          ///Password
                          SizedBox(
                            height: SizeMg.height(20.0),
                          ),
                          TextFormField(
                            controller: password,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: model.passwordHide,
                            style: TextStyle(
                              fontSize: SizeMg.text(16),
                              fontWeight: FontWeight.w400,
                              color: Palette.mainBlack,
                              letterSpacing: 0.3,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: const Icon(
                                Icons.lock_outline_rounded,
                                color: Palette.inactiveTextField,
                              ),
                              suffixIcon: IconButton(
                                onPressed: model.togglePasswordVisibility,
                                icon: Icon(
                                  model.passwordHide
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Palette.inactiveTextField,
                                ),
                              ),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (ValidatorUtils.isEmpty(value)) {
                                return 'Password cannot be left blank';
                              }
                              if (ValidatorUtils.shortPassword(value)) {
                                return 'Password min of 6 characters';
                              }
                              return null;
                            },
                          ),

                          ///ForgotPassword
                          SizedBox(
                            height: SizeMg.height(16),
                          ),
                          GestureDetector(
                            onTap: (){
                              model.moveToForgotPassword();
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Palette.primaryRed,
                                fontSize: SizeMg.text(16),
                              ),
                            ),
                          ),

                          /// Sign In With Email Button
                          PrimaryButton(
                            margin: EdgeInsets.only(
                              top: SizeMg.height(50),
                            ),
                            buttonConfig: ButtonConfig(
                              text: 'Login',
                              action: () {
                                if (_formEmailKey.currentState!.validate()) {
                                  model.signInEmail(
                                    email: email.text.trim(),
                                    password: password.text.trim(),
                                  );
                                }
                                focusManager.primaryFocus?.unfocus();
                              },
                            ),
                          ),

                          /// Sign In With Phone Button
                          OutlinePrimaryButton(
                            margin: EdgeInsets.only(
                              top: SizeMg.height(20),
                            ),
                            buttonConfig: ButtonConfig(
                              text: 'Login using Mobile Number',
                              action: model.togglePage,
                            ),
                          ),

                          ///SignUp text
                          SizedBox(
                            height: SizeMg.height(30.0),
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Don't have an account?  ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: SizeMg.text(16),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Register',
                                  style: const TextStyle(
                                    color: Palette.primaryRed,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = model.moveToSignUpView,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeMg.height(30.0),
                          ),
                        ],
                      ),
                    );
                  }

                  ///Phone Sign in
                  return ListView(
                    padding: EdgeInsets.only(
                      left: SizeMg.width(30.0),
                      right: SizeMg.width(30.0),
                      top: SizeMg.height(30.0),
                    ),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Image.asset(
                        ImageUtils.splashIcon,
                        height: SizeMg.height(100),
                      ),
                      SizedBox(
                        height: SizeMg.height(20),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: SizeMg.text(30.0),
                        ),
                      ),

                      /// Phone Number
                      SizedBox(
                        height: SizeMg.height(80.0),
                      ),
                      IntlPhoneField(
                        initialCountryCode: 'NG',
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                          fontSize: SizeMg.text(16),
                          fontWeight: FontWeight.w400,
                          color: Palette.mainBlack,
                          letterSpacing: 0.3,
                        ),
                        pickerDialogStyle: PickerDialogStyle(
                          searchFieldInputDecoration: kIntlPhoneDecoration,
                        ),
                        dropdownIcon: const Icon(Icons.arrow_drop_down, color: Palette.mainBlack,),
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                        ),
                        onChanged: (phoneNumber){
                          setState(() {
                            number.text = phoneNumber.completeNumber;
                          });
                        },
                      ),

                      /// Sign In With Number Button
                      PrimaryButton(
                        margin: EdgeInsets.only(
                          top: SizeMg.height(50),
                        ),
                        buttonConfig: ButtonConfig(
                          text: 'Login',
                          action: () {
                            model.signInPhoneNumber(
                              phoneNumber: number.text.trim(),
                            );
                            focusManager.primaryFocus?.unfocus();
                          },
                        ),
                      ),

                      /// Sign In With Email Button
                      OutlinePrimaryButton(
                        margin: EdgeInsets.only(
                          top: SizeMg.height(20),
                        ),
                        buttonConfig: ButtonConfig(
                          text: 'Login with Email',
                          action: model.togglePage,
                        ),
                      ),

                      ///SignUp text
                      SizedBox(
                        height: SizeMg.height(30.0),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Don't have an account?  ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: SizeMg.text(16),
                          ),
                          children: [
                            TextSpan(
                              text: 'Register',
                              style: const TextStyle(
                                color: Palette.primaryRed,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = model.moveToSignUpView,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeMg.height(30.0),
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    number.dispose();
    password.dispose();
    super.dispose();
  }
}
